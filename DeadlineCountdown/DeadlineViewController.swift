//
//  DeadlineViewController.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 7/24/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import UIKit
import CoreData

class DeadlineViewController: UIViewController {

    @IBOutlet weak var deadlineLabel: UILabel!
    
    private var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    var storedDate: [DeadlineItems] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        storedDate = DeadlineItems.all()
        let chosenDate = storedDate[storedDate.count-1].date
        let deadline = DeadlineCalculator(chosenDate!).calculate()
        deadlineLabel.text = storedDate[storedDate.count-1].dateTitle! + ": " + DeadlineText(years: deadline.years, months: deadline.months, days: deadline.days).toString()
        
      let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
       swipeRight.direction = .right
     self.view.addGestureRecognizer(swipeRight)
        
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
        // Pass the selected object to the new view controller.
    }
    */

  func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            //let datePickerViewController = self.storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as! DatesTableViewController
            //self.present(datePickerViewController, animated: true, completion: nil)
            //navigationController?.pushViewController(datePickerViewController, animated: true)
           // _ = self.navigationController?.popToRootViewController(animated: true)
            
           
            //let datePickerViewController = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
       // let vc = datePickerViewController.navigationController?.popToRootViewController(animated: false)
           // print(vc as Any)
           // self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
            
          _ = self.navigationController?.popToRootViewController(animated: true)
           //self.dismiss(animated: false, completion: nil)
            
            
        }
    }
}
