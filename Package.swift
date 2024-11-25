// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "XCTestUtils",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(name: "XCTestUtils", targets: ["XCTestUtils"])
    ],
    targets: [
        .target(name: "XCTestUtils"),
        .testTarget(name: "XCTestUtilsTests", dependencies: ["XCTestUtils"])
    ]
)
