//
//  DatesTableViewController.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 8/22/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import UIKit
import CoreData

class DatesTableViewController: UITableViewController {
    
    var storedDatesArray: [DeadlineItems] = []
    
    @IBAction func unwindToDatesTableVC (segue: UIStoryboardSegue) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        storedDatesArray = DeadlineItems.all()
        //storedDatesArray = storedDatesArray.sorted(by: { $0.date?.compare($1.date!) == .orderedAscending })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        storedDatesArray = DeadlineItems.all()
        storedDatesArray = storedDatesArray.sorted(by: { $0.date?.compare($1.date!) == .orderedAscending })
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return storedDatesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath) as UITableViewCell
        
        let dateTitle = storedDatesArray[indexPath.row].dateTitle!
        cell.textLabel?.text = dateTitle
        
        let date = storedDatesArray[indexPath.row].date!
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        
        cell.detailTextLabel?.text = formatter.string(from: date)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueToDeadlineVC", sender: indexPath)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action:UITableViewRowAction, indexPath:IndexPath) in DeadlineItems.deleteOne(index: indexPath.row)
            self.storedDatesArray = DeadlineItems.all()
            tableView.reloadData()
        }
        delete.backgroundColor = .red
        
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action:UITableViewRowAction, indexPath:IndexPath) in
            self.performSegue(withIdentifier: "editDate", sender: indexPath)
        }
        edit.backgroundColor = .orange
        
        return [delete, edit]
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "segueToDeadlineVC" {
            let thirdScene = segue.destination as! DeadlineViewController
            
            if let indexPath = sender {
                let selectedDate = storedDatesArray[(indexPath as AnyObject).row]
                thirdScene.selectedDate = selectedDate
            }
        } else {
            let secondScene = segue.destination as! DatePickerViewController
            
            // Pass the selected object to the new view controller.
            if segue.identifier == "editDate" {
                if let indexPath = sender {
                    let selectedDate = storedDatesArray[(indexPath as AnyObject).row]
                    secondScene.selectedDate = selectedDate
                    secondScene.isEdit = true
                }
            } else if segue.identifier == "segueToDatePickerVC" {
                let selectedDateTitle = ""
                let selectedData = getMinDate()
                
                secondScene.selectedDateTitle = selectedDateTitle
                secondScene.selectedData = selectedData
                secondScene.isEdit = false
            }
        }
    }
    
    private func getMinDate() -> Date {
        var components = DateComponents()
        components.day = 1
        
        return Calendar.current.date(byAdding: components, to: Date())!
    }
}
