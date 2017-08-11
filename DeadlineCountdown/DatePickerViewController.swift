//
//  DatePickerViewController.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 7/24/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import UIKit

import CoreData

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var storedDate: NSManagedObject!
    
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
        //let secondScene = segue.destination as! DeadlineViewController
        // Pass the selected object to the new view controller.
        let chosenDate = self.datePicker.date
        self.save(date: chosenDate)
        //secondScene.chosenDate = chosenDate
    }
    
    func save(date: Date) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Deadline", in: managedContext)!
        let deadline = NSManagedObject(entity: entity, insertInto: managedContext)
        deadline.setValue(date, forKeyPath: "data")
        
        do {
            try managedContext.save()
            storedDate = deadline
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func getMinDate() -> Date {
        var components = DateComponents()
        components.day = 1
        //print("\(Calendar.current.date(byAdding: components, to: Date())!)")
        return Calendar.current.date(byAdding: components, to: Date())!
    }

}
