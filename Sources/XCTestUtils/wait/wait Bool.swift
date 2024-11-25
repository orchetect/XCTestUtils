//
//  wait Bool.swift
//  XCTestUtils • https://github.com/orchetect/XCTestUtils
//  © 2022 Steffan Andrews • Licensed under MIT License
//

#if canImport(XCTest)

import XCTest

extension XCTestCase {
    /// Wait for a condition to be true, with a timeout period.
    ///
    /// Polling defaults to every 10 milliseconds, but can be overridden.
    public func wait(
        for condition: @autoclosure () -> Bool,
        timeout: TimeInterval,
        polling: TimeInterval = 0.010,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let inTime = Date()
        let timeoutTime = inTime + timeout
        
        var continueLooping = true
        var timedOut = false
        
        while continueLooping {
            if Date() >= timeoutTime {
                continueLooping = false
                timedOut = true
                continue
            }
            
            let conditionResult = condition()
            continueLooping = !conditionResult
            if !continueLooping { continue }
            
            wait(sec: polling)
        }
        
        if timedOut {
            var msg = message()
            msg = msg.isEmpty ? "" : ": \(msg)"
            
            XCTFail(
                "wait timed out\(msg)",
                file: file,
                line: line
            )
            return
        }
    }
    
    /// Wait for a condition to be true, with a timeout period.
    ///
    /// Polling defaults to every 10 milliseconds, but can be overridden.
    @_disfavoredOverload
    public func wait(
        for condition: () -> Bool,
        timeout: TimeInterval,
        polling: TimeInterval = 0.010,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let inTime = Date()
        let timeoutTime = inTime + timeout
        
        var continueLooping = true
        var timedOut = false
        
        while continueLooping {
            if Date() >= timeoutTime {
                continueLooping = false
                timedOut = true
                continue
            }
            
            let conditionResult = condition()
            continueLooping = !conditionResult
            if !continueLooping { continue }
            
            wait(sec: polling)
        }
        
        if timedOut {
            var msg = message()
            msg = msg.isEmpty ? "" : ": \(msg)"
            
            XCTFail(
                "wait timed out\(msg)",
                file: file,
                line: line
            )
            return
        }
    }
}

#endif
