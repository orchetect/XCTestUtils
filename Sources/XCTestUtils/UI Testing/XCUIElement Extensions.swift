//
//  XCUIElement Extensions.swift
//  XCTestUtils • https://github.com/orchetect/XCTestUtils
//  © 2022 Steffan Andrews • Licensed under MIT License
//

#if canImport(XCTest)

import XCTest

extension XCUIElement {
    /// Convenience method to wrap `XCUIElement`'s `waitForExistence(timeout:)` in a throwing method.
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
    /// - Parameter timeout: Timeout time interval in seconds.
    @discardableResult
    public func waitForExistence(throwingTimeout timeout: TimeInterval) throws -> Self {
        guard waitForExistence(timeout: timeout) else {
            throw XCTestError(.timeoutWhileWaiting)
        }
        return self
    }
    
    /// Convenience method to wrap `XCUIElement`'s `waitForNonExistence(timeout:)` in a throwing method.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// let okButton = await app.buttons["OK"].firstMatch
    /// try await okButton.waitForNonExistence(throwingTimeout: 2.0)
    /// ```
    public func waitForNonExistence(throwingTimeout timeout: TimeInterval) throws {
        guard waitForNonExistence(timeout: timeout) else {
            throw XCTestError(.timeoutWhileWaiting)
        }
    }
}

#endif
