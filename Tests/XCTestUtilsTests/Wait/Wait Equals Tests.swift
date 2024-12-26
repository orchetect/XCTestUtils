//
//  Wait Equals Tests.swift
//  XCTestUtils • https://github.com/orchetect/XCTestUtils
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import XCTest
import XCTestUtils

final class WaitForConditionEqualsTests: XCTestCase {
    func testWaitForEqual_True() {
        wait(for: true, equals: true, timeout: 0.1)
    }
    
    #if swift(>=5.4)
    /// `XCTExpectFailure()` is only available in Xcode 12.5 or later. Swift 5.4 shipped in Xcode 12.5.
    func testWaitForEqual_False() {
        XCTExpectFailure()
        
        wait(for: false, equals: true, timeout: 0.1)
    }
    #endif
    
    @MainActor
    func testWaitForEqual() {
        @MainActor final class Val: Sendable {
            var someString = "default string"
            func update(_ string: String) {
                someString = string
            }
        }
        
        let val = Val()
        
        // note: this will throw a thread sanitizer warning but it's safe to ignore for this test
        DispatchQueue.global().async { [val] in
            usleep(20000)
            Task { await val.update("new string") }
        }
        
        var str: String { val.someString }
        wait(
            for: str,
            equals: "new string",
            timeout: 0.3,
            "Check someString == 'new string'"
        )
    }
    
    func testWaitForEqualAsync() async throws {
        final actor Val: Sendable {
            var someString = "default string"
            func update(_ string: String) {
                someString = string
            }
        }
        
        let val = Val()
        
        // note: this will throw a thread sanitizer warning but it's safe to ignore for this test
        DispatchQueue.global().async { [val] in
            usleep(20000)
            Task { await val.update("new string") }
        }
        
        await wait(
            for: await val.someString,
            equals: "new string",
            timeout: 0.3,
            "Check someString == 'new string'"
        )
    }
    
    func testWaitClosures() {
        let a = 2
        let b = 3
        
        let check = true
        
        wait(for: { () -> Int in
            let x = a + b
            return x
        }, equals: {
            if check { return 5 } else { return 10 }
        }, timeout: 0.1)
    }
    
    func testWaitClosuresAsync() async throws {
        final actor Val: Sendable {
            let a = 2
            var b: Int { 3 }
        }
        let check = true
        
        let val = Val()
        
        await wait(for: { () -> Int in
            let x = await val.a + val.b
            return x
        }, equals: {
            if check { return 5 } else { return 10 }
        }, timeout: 0.1)
    }
    
    #if swift(>=5.4)
    /// `XCTExpectFailure()` is only available in Xcode 12.5 or later. Swift 5.4 shipped in Xcode 12.5.
    func testWaitClosures_False() {
        XCTExpectFailure()
        
        let a = 2
        let b = 3
        
        let check = false
        
        wait(for: { () -> Int in
            let x = a + b
            return x
        }, equals: {
            if check { return 5 } else { return 10 }
        }, timeout: 0.1)
    }
    #endif
}
