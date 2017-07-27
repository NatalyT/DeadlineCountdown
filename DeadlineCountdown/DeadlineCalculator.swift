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
    
    func calculateCountdown() -> (Int, Int, Int) {
        let date = Date()
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let currentDate = calendar.date(from: components)
        
        //here we change the seconds to years, months and days
        let CompetitionDayDifference = calendar.dateComponents([.year, .month, .day], from: currentDate!, to: self.tillDate)
        
        //finally, here we set the variable to our remaining time
        let yearsLeft = CompetitionDayDifference.year
        let monthsLeft = CompetitionDayDifference.month
        let daysLeft = CompetitionDayDifference.day
        
        return (yearsLeft!, monthsLeft!, daysLeft!)

    }
    
    
}
