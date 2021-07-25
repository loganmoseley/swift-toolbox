import Foundation

public extension Array {
  /// Given an element, intersperses that new element between each of the
  /// elements of the array. Does not add `newElement` to the beginning or end
  /// of the sequence.
  ///
  /// Separate from the Sequence implementation because, according to a test I ran,
  /// this is nearly 3x faster than wrapping the Sequence implementation in an
  /// `Array.init`.
  ///
  /// For more reading, see
  /// - https://hackage.haskell.org/package/base-4.8.2.0/docs/Data-List.html#v:intersperse
  /// - https://reference.wolfram.com/language/ref/Riffle.html
  ///
  /// - Parameter newElement: The element to insert.
  func interspersing(_ newElement: Element) -> [Element] {
    var accumulated: [Element] = []
    for element in self {
      accumulated.append(element)
      accumulated.append(newElement)
    }
    if !accumulated.isEmpty {
      accumulated.removeLast()
    }
    return accumulated
  }
}

public extension Sequence {
  /// Given an element, intersperses that new element between each of the
  /// elements of the sequence. Does not add `newElement` to the beginning or
  /// end of the sequence.
  ///
  /// Separate from the Sequence implementation because this is about 60x faster
  /// than always using the Array implementation.
  ///
  /// For more reading, see
  /// - https://hackage.haskell.org/package/base-4.8.2.0/docs/Data-List.html#v:intersperse
  /// - https://reference.wolfram.com/language/ref/Riffle.html
  ///
  /// - Parameter newElement: The element to insert.
  func interspersing(_ newElement: Element) -> InterspersedSequence<Self> {
    InterspersedSequence(self, newElement)
  }
}

/// A sequence consisting of the given `newElement`, interspersed between the
/// elements of the `Base` sequence. Does not add `newElement` to the beginning
/// or end of the sequence.
///
/// For more reading, see
/// - https://hackage.haskell.org/package/base-4.8.2.0/docs/Data-List.html#v:intersperse
/// - https://reference.wolfram.com/language/ref/Riffle.html
public struct InterspersedSequence<Base> : Sequence, IteratorProtocol where Base : Sequence {
  /// The underlying sequence.
  private let base: Base

  /// The underlying sequence's iterator.
  private var baseIterator: Base.Iterator

  /// Bookkeeping for which we return, an element of Base or the `newElement`.
  private var takeFromBase = true

  /// The interspersed element to return.
  private var newElement: Base.Element

  /// Necessary for looking ahead to decide whether to return `newElement`.
  private var nextFromBase: Base.Element?

  init(_ base: Base, _ newElement: Base.Element) {
    self.base = base
    self.baseIterator = base.makeIterator()
    self.newElement = newElement
    self.nextFromBase = baseIterator.next()
  }

  mutating public func next() -> Base.Element? {
    defer { takeFromBase.toggle() }
    if takeFromBase {
      let current = nextFromBase
      nextFromBase = baseIterator.next()
      return current
    } else {
      return nextFromBase != nil ? newElement : nil
    }
  }
}
