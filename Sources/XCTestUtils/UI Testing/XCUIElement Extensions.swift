//
//  XCUIElement Extensions.swift
//  XCTestUtils • https://github.com/orchetect/XCTestUtils
//  © 2024 Steffan Andrews • Licensed under MIT License
//

#if canImport(XCTest)

import XCTest

extension XCUIElement {
    /// Wraps `XCUIElement`'s `waitForExistence(timeout:)` in a throwing method.
    /// Returns the element if it is found.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// let okButton = try await app
    ///     .buttons["OK"]
    ///     .waitForExistence(throwingTimeout: 2.0)
    ///
    /// await okButton.click()
    /// ```
    ///
    /// - Parameters:
    ///   - timeout: Timeout time interval in seconds.
    ///   - error: Error to throw if the waiter times out.
    /// - Returns: Returns the element if it is found before the timeout expires.
    @discardableResult
    public func waitForExistence(
        throwingTimeout timeout: TimeInterval,
        error: Error = XCTestError(.timeoutWhileWaiting)
    ) throws -> Self {
        guard waitForExistence(timeout: timeout) else {
            throw error
        }
        return self
    }
}

// `waitForNonExistence(timeout:)` and `wait(for:isEqual:timeout:)`
// were introduced in Xcode 16.0
#if compiler(>=6.0)
extension XCUIElement {
    /// Wraps `XCUIElement`'s `waitForNonExistence(timeout:)` in a throwing method.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// let okButton = await app.buttons["OK"].firstMatch
    /// try await okButton.waitForNonExistence(throwingTimeout: 2.0)
    /// ```
    ///
    /// - Parameters:
    ///   - timeout: Timeout time interval in seconds.
    ///   - error: Error to throw if the waiter times out.
    public func waitForNonExistence(
        throwingTimeout timeout: TimeInterval,
        error: Error = XCTestError(.timeoutWhileWaiting)
    ) throws {
        guard waitForNonExistence(timeout: timeout) else {
            throw error
        }
    }
    
    /// Wraps `XCUIElement`'s `wait(for:toEqual:timeout:)` in a throwing method.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// let okButton = await app.staticTexts["Idle"].firstMatch
    /// try await okButton.wait(for: \.label, toEqual: "Active", throwingTimeout: 2.0)
    /// ```
    ///
    /// - Parameters:
    ///   - keyPath: Key path to an equatable property of the element.
    ///   - expectedValue: The expected value of the property to equal.
    ///   - timeout: Timeout time interval in seconds.
    ///   - error: Error to throw if the waiter times out.
    @preconcurrency
    public func wait<V>(
        for keyPath: KeyPath<XCUIElement, V>,
        toEqual expectedValue: V,
        throwingTimeout timeout: TimeInterval,
        error: Error = XCTestError(.timeoutWhileWaiting)
    ) throws where V: Equatable {
        guard wait(for: keyPath, toEqual: expectedValue, timeout: timeout) else {
            throw error
        }
    }
}
#endif

#endif
