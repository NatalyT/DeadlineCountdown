//
//  DeadlineItems.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 8/7/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DeadlineItems {
    
class func all() -> [NSManagedObject] {
        var storedDate: [NSManagedObject] = []
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Deadline")
        do {
            storedDate = try managedContext!.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                }
        return storedDate
    }
    
class func deleteAll(entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }

}
