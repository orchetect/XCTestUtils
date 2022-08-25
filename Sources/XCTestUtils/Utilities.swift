//
//  Utilities.swift
//  SegmentedProgress
//
//  Created by Steffan Andrews on 2019-10-06.
//  Copyright © 2019 Steffan Andrews. All rights reserved.
//

import Foundation

extension Double {
    /// Internal: Utility to format a double rounded to _n_ decimal places as a string.
    func roundedPercentageString(
        toPlaces: Int
    ) -> String {
        // sanitize inputs
        let toPlaces = min(max(0, toPlaces), 100)
	
        // Foundation method:
        return String(format: "%.\(toPlaces)f", self) + "%"
    }
}
