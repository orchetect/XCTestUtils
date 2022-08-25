//
//  SegmentedProgressTests.swift
//  SegmentedProgress
//

#if shouldTestCurrentPlatform

import XCTest
@testable import XCTestUtils

class SegmentedProgressTests: XCTestCase {
    override func setUp() { super.setUp() }
    override func tearDown() { super.tearDown() }
	
    // typical cases
	
    func testSegmentedProgress() {
        let range = 0 ... 100
        var sp = SegmentedProgress(0 ... 100, segments: 4, roundedToPlaces: 0)
		
        var buildString = ""
        for x in range {
            if let result = sp.progress(value: x) {
                buildString += result + " "
            }
        }
		
        buildString = buildString.trimmingCharacters(in: .whitespaces)
		
        XCTAssertEqual(buildString, "0% 25% 50% 75% 100%")
    }
	
    func testSegmentedProgress2DecimalPlaces() {
        let range = 0 ... 100
        var sp = SegmentedProgress(0 ... 100, segments: 4, roundedToPlaces: 2)
		
        var buildString = ""
        for x in range {
            if let result = sp.progress(value: x) {
                buildString += result + " "
            }
        }
		
        buildString = buildString.trimmingCharacters(in: .whitespaces)
		
        XCTAssertEqual(buildString, "0.00% 25.00% 50.00% 75.00% 100.00%")
    }
	
    func testSegmentedProgressNegative1() {
        let range = -50 ... 50
        var sp = SegmentedProgress(range, segments: 4, roundedToPlaces: 0)
		
        var buildString = ""
        for x in range {
            if let result = sp.progress(value: x) {
                buildString += result + " "
            }
        }
		
        buildString = buildString.trimmingCharacters(in: .whitespaces)
		
        XCTAssertEqual(buildString, "0% 25% 50% 75% 100%")
    }
	
    func testSegmentedProgressNegative2() {
        let range = (-150) ... (-50)
        var sp = SegmentedProgress(range, segments: 4, roundedToPlaces: 0)
		
        var buildString = ""
        for x in range {
            if let result = sp.progress(value: x) {
                buildString += result + " "
            }
        }
		
        buildString = buildString.trimmingCharacters(in: .whitespaces)
		
        XCTAssertEqual(buildString, "0% 25% 50% 75% 100%")
    }
	
    // outlier cases
	
    func testSegmentedProgressOneStep() {
        let range = 0 ... 1
        var sp = SegmentedProgress(range, segments: 4, roundedToPlaces: 0)
		
        var buildString = ""
        for x in range {
            if let result = sp.progress(value: x) {
                buildString += result + " "
            }
        }
		
        buildString = buildString.trimmingCharacters(in: .whitespaces)
		
        XCTAssertEqual(buildString, "0% 100%")
    }
	
    func testSegmentedProgressOneSegment() {
        let range = 0 ... 100
        var sp = SegmentedProgress(range, segments: 1, roundedToPlaces: 0)
		
        var buildString = ""
        for x in range {
            if let result = sp.progress(value: x) {
                buildString += result + " "
            }
        }
		
        buildString = buildString.trimmingCharacters(in: .whitespaces)
		
        XCTAssertEqual(buildString, "0% 100%")
    }
	
    // malformed
	
    func testSegmentedProgressMalformed() {
        // check validation for init params and enact defaults
		
        let range = 0 ... 100
        var sp = SegmentedProgress(range, segments: -1, roundedToPlaces: -1)
		
        var buildString = ""
        for x in range {
            if let result = sp.progress(value: x) {
                buildString += result + " "
            }
        }
		
        buildString = buildString.trimmingCharacters(in: .whitespaces)
		
        XCTAssertEqual(buildString, "0% 100%")
    }
}

#endif
