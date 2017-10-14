//
//  DeadlineText.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 7/27/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import Foundation

class DeadlineText {
    
    var date: (years: Int, months: Int, days: Int)
    
    init(years: Int, months: Int, days: Int) {
        date.years = years
        date.months = months
        date.days = days
    }
    
    func toString() -> String {
        var parts = [String]()
        if (date.years > 0) {
            parts.append("\(date.years)y")
        }
        
        if (date.months > 0) {
            parts.append("\(date.months)m")
        }
        
        if (date.days > 0) {
            parts.append("\(date.days)d")
        }
        
        if (parts.isEmpty) {
            return "is Today"
        }
        return parts.joined(separator: "   ")
    }
}
