// swift-tools-version:5.4

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
