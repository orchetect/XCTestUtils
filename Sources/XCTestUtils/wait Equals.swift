//
//  wait Equals.swift
//  XCTestUtils • https://github.com/orchetect/XCTestUtils
//

#if currentPlatformSupportsXCTest && canImport(XCTest)

import XCTest

extension XCTestCase {
    
    /// Wait for an equality condition to be true, with a timeout period.
    /// 
    /// Polling defaults to every 10 milliseconds, but can be overridden.
    public func wait<T>(
        for lhs: @autoclosure () throws -> T,
        equals rhs: @autoclosure () throws -> T,
        timeout: TimeInterval,
        polling: TimeInterval = 0.010,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) where T : Equatable {
        
        let inTime = Date()
        let timeoutTime = inTime + timeout
        let pollingPeriodMicroseconds = UInt32(polling * 1_000_000)
        
        var continueLooping = true
        var timedOut = false
        
        while continueLooping {
            if Date() >= timeoutTime {
                continueLooping = false
                timedOut = true
                continue
            }
            
            let conditionResult = (try? lhs() == rhs()) ?? false
            continueLooping = !conditionResult
            if !continueLooping { continue }
            
            usleep(pollingPeriodMicroseconds)
        }
        
        if timedOut {
            var msg = message()
            msg = msg.isEmpty ? "" : ": \(msg)"
            
            try XCTAssertEqual(lhs(), rhs(),
                               "wait timeout",
                               file: file,
                               line: line)
            return
        }
        
    }
    
}

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
