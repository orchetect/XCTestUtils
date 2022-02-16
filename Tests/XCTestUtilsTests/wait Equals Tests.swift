//
//  wait Equals Tests.swift
//  XCTestUtils • https://github.com/orchetect/XCTestUtils
//

#if currentPlatformSupportsXCTest

import XCTest
import XCTestUtils

class Utilities_WaitForEqualTests: XCTestCase {
    
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
    
    func testWaitForEqual() {
        
        var someString = "default string"
        
        // note: this will throw a thread sanitizer warning but it's safe to ignore for this test
        DispatchQueue.global().async {
            usleep(20_000)
            someString = "new string"
        }
        
        wait(for: someString, equals: "new string",
             timeout: 0.3,
             "Check someString == 'new string'")
        
    }
    
}

#endif