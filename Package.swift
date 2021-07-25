// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "swift-toolbox",
  products: [
    .library(name: "Collections", targets: ["Collections"]),
  ],
  targets: [
    .target(name: "Collections", dependencies: []),
    .testTarget( name: "CollectionsTests", dependencies: ["Collections"]),
  ]
)
