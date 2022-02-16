//
//  wait Bool Tests.swift
//  XCTestUtils • https://github.com/orchetect/XCTestUtils
//

#if shouldTestCurrentPlatform

import XCTest
import XCTestUtils

class Utilities_WaitForConditionTests: XCTestCase {
    
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
            usleep(20_000)
            someString = "new string"
        }
        
        wait(for: someString == "new string",
             timeout: 0.3,
             "Check someString == 'new string'")
        
    }
    
}

#endif
