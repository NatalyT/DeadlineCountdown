//
//  DeadlineViewController.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 7/24/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import UIKit
//import CoreData
//import Crashlytics

class DeadlineViewController: UIViewController {

    @IBOutlet weak var deadlineLabel: InsetLabel!
    @IBOutlet weak var dateTitleLabel: InsetLabel!
    
   /* @IBAction func crashButtonTapped(_ sender: AnyObject) {
        Crashlytics.sharedInstance().crash()
    }
    */
    
    private var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    var selectedDate: DeadlineItems?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "bg")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
       /* let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
        button.setTitle("Crash", for: [])
        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(button)*/
        
        deadlineLabel.backgroundColor = UIColor(white: 0, alpha: 0.5)
        dateTitleLabel.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let chosenDate = selectedDate?.date
        let deadline = DeadlineCalculator(chosenDate!).calculate()
        deadlineLabel.text = DeadlineText(years: deadline.years, months: deadline.months, days: deadline.days).toString()
        if deadlineLabel.text == "is Today" {
            dateTitleLabel.text = (selectedDate?.dateTitle!)!
        } else {
            dateTitleLabel.text = (selectedDate?.dateTitle!)! + " in"
        }
        
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

    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
