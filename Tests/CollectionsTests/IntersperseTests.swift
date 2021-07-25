import XCTest
@testable import Collections

final class IntersperseTests: XCTestCase {

  // MARK: Array

  func testArrayIntersperseInEmpty() {
    let xs: [Int] = []
    let sut = xs.interspersing(42)
    XCTAssertEqual(sut, [])
  }

  func testArrayIntersperseInOne() {
    let xs: [Int] = [0]
    let sut = xs.interspersing(42)
    XCTAssertEqual(sut, [0])
  }

  func testArrayIntersperseInTwo() {
    let xs: [Int] = [0, 1]
    let sut = xs.interspersing(42)
    XCTAssertEqual(sut, [0, 42, 1])
  }

  func testArrayIntersperseInMany() {
    let xs: [Int] = [0, 1, 2, 3, 4, 5]
    let sut = xs.interspersing(42)
    XCTAssertEqual(sut, [0, 42, 1, 42, 2, 42, 3, 42, 4, 42, 5])
  }

  func testArrayInterspersePerformance() {
    measure {
      let xs = Array(repeating: 42, count: 1_000_000)
      _ = xs.interspersing(13)
    }
  }

  // MARK: Sequence

  func testSequenceIntersperseInEmpty() {
    let xs = AnySequence([Int]())
    let sut = xs.interspersing(42)
    XCTAssertEqual(Array(sut), [])
  }

  func testSequenceIntersperseInOne() {
    let xs = AnySequence([0])
    let sut = xs.interspersing(42)
    XCTAssertEqual(Array(sut), [0])
  }

  func testSequenceIntersperseInTwo() {
    let xs = AnySequence([0, 1])
    let sut = xs.interspersing(42)
    XCTAssertEqual(Array(sut), [0, 42, 1])
  }

  func testSequenceIntersperseInMany() {
    let xs = AnySequence([0, 1, 2, 3, 4, 5])
    let sut = xs.interspersing(42)
    XCTAssertEqual(Array(sut), [0, 42, 1, 42, 2, 42, 3, 42, 4, 42, 5])
  }

  func testSequenceInterspersePerformance() {
    measure {
      let xs = AnySequence(Array(repeating: 42, count: 1_000_000))
      _ = xs.interspersing(13)
    }
  }
}
