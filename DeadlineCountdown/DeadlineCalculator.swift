//
//  DeadlineCalculator.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 7/27/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import Foundation

class DeadlineCalculator {
    
    var tillDate: Date
    
    init(_ date: Date) {
        tillDate = date
    }
    
    func calculate() -> (years: Int, months: Int, days: Int) {
        let date = Date()
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let currentDate = calendar.date(from: components)
        
        //here we change the seconds to years, months and days
        let CompetitionDayDifference = calendar.dateComponents([.year, .month, .day], from: currentDate!, to: self.tillDate)

        
        return (
            years: CompetitionDayDifference.year!,
            months: CompetitionDayDifference.month!,
            days: CompetitionDayDifference.day!
        )

    }
    
    
}
