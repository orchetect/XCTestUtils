//
//  wait Equals.swift
//  XCTestUtils • https://github.com/orchetect/XCTestUtils
//  © 2022 Steffan Andrews • Licensed under MIT License
//

#if shouldTestCurrentPlatform && canImport(XCTest)

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
    ) where T: Equatable {
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
            
            let conditionResult = (try? lhs() == rhs()) ?? false
            continueLooping = !conditionResult
            if !continueLooping { continue }
            
            wait(sec: polling)
        }
        
        if timedOut {
            var msg = message()
            msg = msg.isEmpty ? "" : ": \(msg)"
            
            try XCTAssertEqual(
                lhs(),
                rhs(),
                "wait timeout",
                file: file,
                line: line
            )
            return
        }
    }
    
    /// Wait for an equality condition to be true, with a timeout period.
    ///
    /// Polling defaults to every 10 milliseconds, but can be overridden.
    @_disfavoredOverload
    public func wait<T>(
        for lhs: () throws -> T,
        equals rhs: () throws -> T,
        timeout: TimeInterval,
        polling: TimeInterval = 0.010,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) where T: Equatable {
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
            
            let conditionResult = (try? lhs() == rhs()) ?? false
            continueLooping = !conditionResult
            if !continueLooping { continue }
            
            wait(sec: polling)
        }
        
        if timedOut {
            var msg = message()
            msg = msg.isEmpty ? "" : ": \(msg)"
            
            try XCTAssertEqual(
                lhs(),
                rhs(),
                "wait timeout",
                file: file,
                line: line
            )
            return
        }
    }
}

#endif
