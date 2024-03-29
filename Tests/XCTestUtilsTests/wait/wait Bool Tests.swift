//
//  wait Bool Tests.swift
//  XCTestUtils • https://github.com/orchetect/XCTestUtils
//  © 2022 Steffan Andrews • Licensed under MIT License
//

#if shouldTestCurrentPlatform

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
    
    func testWaitForCondition() {
        var someString = "default string"
        
        // note: this will throw a thread sanitizer warning but it's safe to ignore for this test
        DispatchQueue.global().async {
            usleep(20000)
            someString = "new string"
        }
        
        wait(
            for: someString == "new string",
            timeout: 0.3,
            "Check someString == 'new string'"
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

#endif
