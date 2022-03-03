//
//  wait Tests.swift
//  XCTestUtils • https://github.com/orchetect/XCTestUtils
//

#if currentPlatformSupportsXCTest

import XCTest
import XCTestUtils

class WaitTests: XCTestCase {
    
    func testWaitForEqual_True() {
        
        let inTime = Date().timeIntervalSince1970
        
        wait(sec: 1.0)
        
        let outTime = Date().timeIntervalSince1970
        
        let diff = outTime - inTime
                                        
        XCTAssertGreaterThan(diff, 0.99999)
        XCTAssertLessThan(diff, 1.25)
        
    }
    
}

#endif
