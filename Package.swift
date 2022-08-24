// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "XCTestUtils",
    
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v9), .watchOS(.v2)
    ],
    
    products: [
        .library(
            name: "XCTestUtils",
            targets: ["XCTestUtils"]
        )
    ],
    
    dependencies: [
        // none
    ],
    
    targets: [
        .target(
            name: "XCTestUtils",
            dependencies: []
        ),
        .testTarget(
            name: "XCTestUtilsTests",
            dependencies: ["XCTestUtils"]
        )
    ]
)

func addShouldTestFlag() {
    // swiftSettings may be nil so we can't directly append to it
    
    var swiftSettings = package.targets
        .first(where: { $0.name == "PListKitTests" })?
        .swiftSettings ?? []
    
    swiftSettings.append(.define("shouldTestCurrentPlatform"))
    
    package.targets
        .first(where: { $0.name == "PListKitTests" })?
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
