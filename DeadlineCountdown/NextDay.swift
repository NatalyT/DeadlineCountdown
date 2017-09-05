//
//  DateMin.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 9/5/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import Foundation

class NextDay {
    
    class func get() -> Date {
        var components = DateComponents()
        components.day = 1
        
        return Calendar.current.date(byAdding: components, to: Date())!
    }
}
