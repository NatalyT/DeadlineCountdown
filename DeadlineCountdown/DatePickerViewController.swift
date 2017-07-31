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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        datePicker.minimumDate = getMinDate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let secondScene = segue.destination as! DeadlineViewController
        // Pass the selected object to the new view controller.
        let chosenDate = self.datePicker.date
        secondScene.chosenDate = chosenDate
    
    }
    
    private func getMinDate() -> Date {
        var components = DateComponents()
        components.day = 1
        return Calendar.current.date(byAdding: components, to: Date())!
    }

}
