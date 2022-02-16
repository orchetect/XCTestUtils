// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "XCTestUtils",
    
    products: [
        .library(
            name: "XCTestUtils",
            targets: ["XCTestUtils"]),
    ],
    
    dependencies: [
        // none
    ],
    
    targets: [
        .target(
            name: "XCTestUtils",
            dependencies: []),
        .testTarget(
            name: "XCTestUtilsTests",
            dependencies: ["XCTestUtils"]),
    ]
)

func addShouldTestFlag() {
    var swiftSettings = package.targets
        .first(where: { $0.name == "XCTestUtilsTests" })?
        .swiftSettings ?? []
    
    swiftSettings.append(.define("shouldTestCurrentPlatform"))
    
    package.targets
        .first(where: { $0.name == "XCTestUtilsTests" })?
        .swiftSettings = swiftSettings
}

// Swift version in Xcode 12.5.1 which introduced watchOS testing
#if os(watchOS) && swift(>=5.4.2)
addShouldTestFlag()
#elseif os(watchOS)
// don't add flag
#else
addShouldTestFlag()
#endif
