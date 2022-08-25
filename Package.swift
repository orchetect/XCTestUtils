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
    // XCTestUtils requires this flag in all targets, not just test targets
    package.targets /* .map { $0.isTest } */ .forEach { target in
        if target.swiftSettings == nil { target.swiftSettings = [] }
        target.swiftSettings?.append(.define("shouldTestCurrentPlatform"))
    }
}

// Xcode 12.5.1 (Swift 5.4.2) introduced watchOS testing
#if swift(>=5.4.2)
addShouldTestFlag()
#elseif !os(watchOS)
addShouldTestFlag()
#endif
