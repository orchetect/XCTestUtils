// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "XCTestUtils",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v9), .watchOS(.v2)
    ],
    products: [
        .library(name: "XCTestUtils", targets: ["XCTestUtils"])
    ],
    targets: [
        .target(name: "XCTestUtils"),
        .testTarget(name: "XCTestUtilsTests", dependencies: ["XCTestUtils"])
    ]
)
