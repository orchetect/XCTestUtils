//
//  wait.swift
//  XCTestUtils • https://github.com/orchetect/XCTestUtils
//

#if currentPlatformSupportsXCTest && canImport(XCTest)

import XCTest

extension XCTestCase {
    /// Simple XCTest wait timer that does not block the runloop.
    /// - Parameter timeout: floating-point duration in seconds.
    @_disfavoredOverload
    public func wait(sec timeout: Double) {
        let delayExpectation = XCTestExpectation()
        delayExpectation.isInverted = true
        wait(for: [delayExpectation], timeout: timeout)
    }
}

#endif
