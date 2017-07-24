//
//  DatePickerViewController.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 7/24/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func countDown(_ sender: Any) {
        let chosenDate = self.datePicker.date
        
        let date = NSDate()
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .day], from: date as Date)
        
        let currentDate = calendar.date(from: components)
        
        //here we change the seconds to years, months and days
        let CompetitionDayDifference = calendar.dateComponents([.year, .month, .day], from: currentDate!, to: chosenDate)
        
        //finally, here we set the variable to our remaining time
        let yearsLeft = CompetitionDayDifference.year
        let monthsLeft = CompetitionDayDifference.month
        let daysLeft = CompetitionDayDifference.day
        
        print("years:", yearsLeft ?? "N/A", "months:", monthsLeft ?? "N/A", "days:", daysLeft ?? "N/A")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
