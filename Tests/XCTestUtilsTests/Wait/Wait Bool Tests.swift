//
//  Wait Bool Tests.swift
//  XCTestUtils • https://github.com/orchetect/XCTestUtils
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import XCTest
import XCTestUtils

final class WaitForConditionTests: XCTestCase {
    func testWaitForCondition_True() {
        wait(for: true, timeout: 0.1)
    }
    
    #if swift(>=5.4)
    /// `XCTExpectFailure()` is only available in Xcode 12.5 or later. Swift 5.4 shipped in Xcode 12.5.
    func testWaitForCondition_False() {
        XCTExpectFailure()
        
        wait(for: false, timeout: 0.1)
    }
    #endif
    
    @MainActor
    func testWaitForCondition() {
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
        
        var exp: Bool { val.someString == "new string" }
        wait(
            for: exp,
            timeout: 0.3,
            "Check someString"
        )
    }
    
    func testWaitForConditionAsync() async {
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
            for: await val.someString == "new string",
            timeout: 0.3,
            "Check someString"
        )
    }
    
    func testWaitClosures() {
        let a = 2
        let b = 3
        
        let check = true
        
        wait(for: {
            let x = a + b
            let y = check ? 5 : 10
            return x == y
        }, timeout: 0.1)
    }
    
    func testWaitClosuresAsync() async {
        final actor Val: Sendable {
            let a = 2
            var b: Int { 3 }
        }
        let check = true
        
        let val = Val()
        
        await wait(for: {
            let x = await val.a + val.b
            let y = check ? 5 : 10
            return x == y
        }, timeout: 0.1)
    }
    
    #if swift(>=5.4)
    /// `XCTExpectFailure()` is only available in Xcode 12.5 or later. Swift 5.4 shipped in Xcode 12.5.
    func testWaitClosures_False() {
        XCTExpectFailure()
        
        let a = 2
        let b = 3
        
        let check = false
        
        wait(for: {
            let x = a + b
            let y = check ? 5 : 10
            return x == y
        }, timeout: 0.1)
    }
    #endif
}
