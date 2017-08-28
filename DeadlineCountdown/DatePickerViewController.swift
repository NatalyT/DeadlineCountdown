//
//  DatePickerViewController.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 7/24/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import UIKit
import CoreData

class DatePickerViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleDate: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var storedDate: NSManagedObject!
    var storedDateArray: [DeadlineItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        storedDateArray = DeadlineItems.all()
        datePicker.minimumDate = getMinDate()
        /*if storedDateArray.count != 0 {
            titleDate.text = storedDateArray[storedDateArray.count-1].dateTitle!
            datePicker.date = storedDateArray[storedDateArray.count-1].date!
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        //let secondScene = segue.destination as! DeadlineViewController
        // Pass the selected object to the new view controller.
        self.save(date: self.datePicker.date, titleOfDate: self.titleDate.text!)
        self.titleDate.resignFirstResponder()
    }
    
    func save(date: Date, titleOfDate: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        storedDateArray = DeadlineItems.all()
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Deadline", in: managedContext)!
        let deadline = NSManagedObject(entity: entity, insertInto: managedContext)
        
        do {
            deadline.setValue(date, forKeyPath: "data")
            deadline.setValue(titleOfDate, forKey: "titleDate")
            
            try deadline.managedObjectContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }        
    }
    
    private func getMinDate() -> Date {
        var components = DateComponents()
        components.day = 1
        return Calendar.current.date(byAdding: components, to: Date())!
    }

}
