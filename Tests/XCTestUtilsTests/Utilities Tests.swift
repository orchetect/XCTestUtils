//
//  Utilities Tests.swift
//  SegmentedProgress
//

#if shouldTestCurrentPlatform

import XCTest
@testable import XCTestUtils

class UtilitiesTests: XCTestCase {
    override func setUp() { super.setUp() }
    override func tearDown() { super.tearDown() }
	
    func testRoundedPercentageString() {
        // 0.0000000019
		
        XCTAssertEqual(
            0.0000000019.roundedPercentageString(toPlaces: 0),
            "0%"
        )
		
        XCTAssertEqual(
            0.0000000019.roundedPercentageString(toPlaces: 2),
            "0.00%"
        )
		
        // 0.019
		
        XCTAssertEqual(
            0.019.roundedPercentageString(toPlaces: -1),
            "0%"
        )
		
        XCTAssertEqual(
            0.019.roundedPercentageString(toPlaces: 0),
            "0%"
        )
		
        XCTAssertEqual(
            0.019.roundedPercentageString(toPlaces: 1),
            "0.0%"
        )
		
        XCTAssertEqual(
            0.019.roundedPercentageString(toPlaces: 2),
            "0.02%"
        )
		
        XCTAssertEqual(
            0.019.roundedPercentageString(toPlaces: 3),
            "0.019%"
        )
		
        XCTAssertEqual(
            0.019.roundedPercentageString(toPlaces: 4),
            "0.0190%"
        )
		
        // 0
		
        XCTAssertEqual(
            0.0.roundedPercentageString(toPlaces: -1),
            "0%"
        )
		
        XCTAssertEqual(
            0.0.roundedPercentageString(toPlaces: 0),
            "0%"
        )
		
        XCTAssertEqual(
            0.0.roundedPercentageString(toPlaces: 1),
            "0.0%"
        )
		
        XCTAssertEqual(
            0.0.roundedPercentageString(toPlaces: 2),
            "0.00%"
        )
		
        XCTAssertEqual(
            0.0.roundedPercentageString(toPlaces: 3),
            "0.000%"
        )
		
        // 1
		
        XCTAssertEqual(
            1.0.roundedPercentageString(toPlaces: -1),
            "1%"
        )
		
        XCTAssertEqual(
            1.0.roundedPercentageString(toPlaces: 0),
            "1%"
        )
		
        XCTAssertEqual(
            1.0.roundedPercentageString(toPlaces: 1),
            "1.0%"
        )
		
        XCTAssertEqual(
            1.0.roundedPercentageString(toPlaces: 2),
            "1.00%"
        )
		
        XCTAssertEqual(
            1.0.roundedPercentageString(toPlaces: 3),
            "1.000%"
        )
		
        // 542.768
		
        XCTAssertEqual(
            542.768.roundedPercentageString(toPlaces: -1),
            "543%"
        )
		
        XCTAssertEqual(
            542.768.roundedPercentageString(toPlaces: 0),
            "543%"
        )
		
        XCTAssertEqual(
            542.768.roundedPercentageString(toPlaces: 1),
            "542.8%"
        )
		
        XCTAssertEqual(
            542.768.roundedPercentageString(toPlaces: 2),
            "542.77%"
        )
		
        XCTAssertEqual(
            542.768.roundedPercentageString(toPlaces: 3),
            "542.768%"
        )
		
        XCTAssertEqual(
            542.768.roundedPercentageString(toPlaces: 4),
            "542.7680%"
        )
    }
}

#endif
