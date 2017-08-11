//
//  DeadlineViewController.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 7/24/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import UIKit
import CoreData

class DeadlineViewController: UIViewController /*, UIApplicationDelegate */{

    @IBOutlet weak var deadlineLabel: UILabel!
    
    private var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    //var chosenDate: Date?
    
    var storedDate: [NSManagedObject] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        storedDate = DeadlineItems.all()
        let date = storedDate[storedDate.count-1]
        let chosenDate = date.value(forKey: "data") as? Date
        
        let deadline = DeadlineCalculator(chosenDate!).calculate()
   
        deadlineLabel.text = DeadlineText(years: deadline.years, months: deadline.months, days: deadline.days).toString()
        
       let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    /* func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        self.performSegue(withIdentifier: "rightSegue", sender: nil)
    }
    */
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rightSegue" {
            let destinationVC = segue.destination as? DatePickerViewController
            //destinationVC?.perform()
            }
    }
    */
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

    func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            //self.dismiss(animated: true, completion: nil)
            let datePickerViewController = DatePickerViewController()
            self.present(datePickerViewController, animated: true, completion: nil)
            
        }
    }
}
