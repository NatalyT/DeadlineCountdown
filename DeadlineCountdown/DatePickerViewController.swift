//
//  DatePickerViewController.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 7/24/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import UIKit
import CoreData
import EventKit

class DatePickerViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleDate: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func saveDate(_ sender: Any) {
        self.save(date: self.datePicker.date, titleOfDate: self.titleDate.text!)
        self.titleDate.resignFirstResponder()
        self.performSegue(withIdentifier: "unwindToDatesTableVC", sender: self)
    }
    
    var storedDateArray: [DeadlineItems] = []
    var selectedDate: DeadlineItems?
    var isEdit: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        storedDateArray = DeadlineItems.all()
        if self.isEdit! {
            titleDate.text = selectedDate?.dateTitle
            datePicker.date = (selectedDate?.date)!
        }
        datePicker.minimumDate = NextDay.get()
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
    
    
    func save(date: Date, titleOfDate: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var deadline: NSManagedObject
        var newEventId: String?
        
        if self.isEdit! {
            deadline = (self.selectedDate?.coreDataItem!)!
            newEventId = self.selectedDate?.eventIdentificator
            CalendarEvents().editEvent(savedEventId: newEventId!, title: titleOfDate, startDate: date, endDate: date)
        } else {
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Deadline", in: managedContext)!
            deadline = NSManagedObject(entity: entity, insertInto: managedContext)
            newEventId = CalendarEvents().addEventToCalendar(title: titleOfDate, description: "", startDate: date, endDate: date)
        }
        
        deadline.setValue(date, forKeyPath: "data")
        deadline.setValue(titleOfDate, forKey: "titleDate")
        deadline.setValue(newEventId, forKey: "eventId")
        
        do {
            try deadline.managedObjectContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
