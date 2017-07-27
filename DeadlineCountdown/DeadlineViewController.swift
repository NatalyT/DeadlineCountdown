//
//  DeadlineViewController.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 7/24/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import UIKit

class DeadlineViewController: UIViewController {

    @IBOutlet weak var deadlineLabel: UILabel!
    
    var chosenDate: Date?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let deadline = DeadlineCalculator(chosenDate!).calculate()
        
        deadlineLabel.text = DeadlineText(years: deadline.years, months: deadline.months, days: deadline.days).toString()
        
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