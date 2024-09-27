# XCTestUtils

[![CI Build Status](https://github.com/orchetect/XCTestUtils/actions/workflows/build.yml/badge.svg)](https://github.com/orchetect/XCTestUtils/actions/workflows/build.yml) [![Platforms - macOS 10.10+ | iOS 9+ | tvOS 9+ | watchOS 2+ | visionOS 1+](https://img.shields.io/badge/platforms-macOS%2010.10+%20|%20iOS%209+%20|%20tvOS%209+%20|%20watchOS%202+%20|%20visionOS%201+-lightgrey.svg?style=flat)](https://developer.apple.com/swift) ![Swift 5.3-5.9](https://img.shields.io/badge/Swift-5.3–5.9-orange.svg?style=flat) [![Xcode 12.0-15](https://img.shields.io/badge/Xcode-12.0–15-blue.svg?style=flat)](https://developer.apple.com/swift) [![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/orchetect/XCTestUtils/blob/main/LICENSE)

Useful XCTest utilities and extensions for test targets.

## Overview

Currently, the library provides a small but useful set of XCTest related methods.

## Wait for Expression

Two wait methods are implemented which may be useful in asynchronous testing scenarios where using XCTest expectations is not possible.

These methods allow for the continuous evaluation of an autoclosure expression with a timeout period in seconds. If the wait times out, it triggers a test fail. The evaluation is done every 10 milliseconds by default, but the interfal can be overridden with a custom polling period.

```swift
// wait for expression:
// useful for non-equatability tests or tests where the test value
// is not required to be logged in failure log messages
// (akin to XCTAssertTrue)
wait(for: x > 10, timeout: 1.5)
wait(for: x > 10, timeout: 1.5, "Description of waiter")

// closures can also be used for more complex expressions
wait(for: {
    let x = a + b
    let y = check ? 5 : 10
    return x == y
}, timeout: 1.5)
```

```swift
// wait for equality:
// useful where the test value is required to be logged in failure log messages
// (akin to XCTAssertEqual)
wait(for: x, equals: 10, timeout: 1.5)
wait(for: x, equals: 10, timeout: 1.5, "Description of waiter")

// closures can also be used for more complex expressions
wait(for: {
    let x = a + b
    return x > 10
}, equals: {
    #if os(macOS)
        10
    #else
        15
    #endif
}, timeout: 1.5)
```

### General Wait

A generic non-blocking wait method is also provided:

```swift
wait(sec: 1.5) // seconds
```

## Installation: Swift Package Manager (SPM)

### Dependency within an Application

1. Add the package to your Xcode project's test target(s) using Swift Package Manager

   - Select File → Swift Packages → Add Package Dependency
   - Add package using  `https://github.com/orchetect/XCTestUtils` as the URL.

2. Import the module in your *.swift test files where needed.

   ```swift
   import XCTest
   import XCTestUtils
   ```

### Dependency within a Swift Package

1. Add the dependency in your Package.swift file:

   ```swift
   dependencies: [
       .package(url: "https://github.com/orchetect/XCTestUtils", from: "1.0.0")
   ],
   ```

2. Import the module in your *.swift test files where needed.

   ```swift
   import XCTest
   import XCTestUtils
   ```

Most methods are implemented as category methods so they are generally discoverable.

All methods have inline help explaining their purpose and basic usage examples.

## Author

Coded by a bunch of 🐹 hamsters in a trenchcoat that calls itself [@orchetect](https://github.com/orchetect).

## License

Licensed under the MIT license. See [LICENSE](https://github.com/orchetect/XCTestUtils/blob/master/LICENSE) for details.

## Contributions

Bug fixes and improvements are welcome. Please open an issue to discuss prior to submitting PRs.

