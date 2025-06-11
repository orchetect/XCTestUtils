# XCTestUtils

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Forchetect%2FXCTestUtils%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/orchetect/XCTestUtils) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Forchetect%2FXCTestUtils%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/orchetect/XCTestUtils) [![Xcode 13-16](https://img.shields.io/badge/Xcode-13–16-blue.svg?style=flat)](https://developer.apple.com/swift) [![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/orchetect/XCTestUtils/blob/main/LICENSE)

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

### UI Testing

A small assortment of throwing wrappers for `XCUIElement` methods are implemented.

`waitForExistence(timeout:) -> Bool` wrapped in a throwing method:

```swift
let okButton = try await app
    .buttons["OK"]
    .waitForExistence(throwingTimeout: 2.0)

await okButton.click()
```

`waitForNonExistence(timeout:) -> Bool` wrapped in a throwing method:

```swift
let okButton = await app.buttons["OK"].firstMatch
try await okButton.waitForNonExistence(throwingTimeout: 2.0)
```

`wait(for:toEqual:timeout:) -> Bool` wrapped in a throwing method:

```swift
let okButton = await app.staticTexts["Idle"].firstMatch
try await okButton.wait(for: \.label, toEqual: "Active", throwingTimeout: 2.0)
```

## Installation: Swift Package Manager (SPM)

### Dependency within an Application

1. Add the package to your Xcode project's test target(s) using `https://github.com/orchetect/XCTestUtils` as the URL.

2. Import the module in your test files where needed.

   ```swift
   import XCTest
   import XCTestUtils
   ```

### Dependency within a Swift Package

1. Add the dependency in your `Package.swift` file:

   ```swift
   dependencies: [
       .package(url: "https://github.com/orchetect/XCTestUtils", from: "1.1.2")
   ],
   ```

## Usage

Import the module in test files where needed.

```swift
import XCTest
import XCTestUtils
```

## Documentation

This README serves as basic documentation.

All methods have inline help explaining their purpose and basic usage examples.

## Requirements

Minimum system requirements for testing: Xcode 13 or higher on macOS 11.3 or higher

## Author

Coded by a bunch of 🐹 hamsters in a trenchcoat that calls itself [@orchetect](https://github.com/orchetect).

## License

Licensed under the MIT license. See [LICENSE](https://github.com/orchetect/XCTestUtils/blob/master/LICENSE) for details.

## Community & Support

Please do not email maintainers for technical support. Several options are available for issues and questions:

- Questions and feature ideas can be posted to [Discussions](https://github.com/orchetect/XCTestUtils/discussions).
- If an issue is a verifiable bug with reproducible steps it may be posted in [Issues](https://github.com/orchetect/XCTestUtils/issues).

## Contributions

Contributions are welcome. Posting in [Discussions](https://github.com/orchetect/XCTestUtils/discussions) first prior to new submitting PRs for features or modifications is encouraged.
