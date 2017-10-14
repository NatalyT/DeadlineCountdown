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
import GoogleMobileAds
import AudioToolbox

class DatePickerViewController: UIViewController, UITextFieldDelegate, GADBannerViewDelegate {
    
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
    
    // Ad banner and interstitial views
    var adMobBannerView = GADBannerView()
    let ADMOB_BANNER_UNIT_ID = "ca-app-pub-9691910327507240/6202482590"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init AdMob banner
        initAdMobBanner()
        
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
    
    // MARK: -  ADMOB BANNER
    func initAdMobBanner() {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            // iPhone
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
            adMobBannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 320, height: 50)
        } else  {
            // iPad
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 468, height: 60))
            adMobBannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 468, height: 60)
        }
        
        adMobBannerView.adUnitID = ADMOB_BANNER_UNIT_ID
        adMobBannerView.rootViewController = self
        adMobBannerView.delegate = self
        view.addSubview(adMobBannerView)
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        //request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9b" ];
        adMobBannerView.load(request)
    }
    
    
    // Hide the banner
    func hideBanner(_ banner: UIView) {
        UIView.beginAnimations("hideBanner", context: nil)
        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        UIView.commitAnimations()
        banner.isHidden = true
    }
    
    // Show the banner
    func showBanner(_ banner: UIView) {
        UIView.beginAnimations("showBanner", context: nil)
        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        UIView.commitAnimations()
        banner.isHidden = false
    }
    
    // AdMob banner available
    func adViewDidReceiveAd(_ view: GADBannerView) {
        showBanner(adMobBannerView)
    }
    
    // NO AdMob banner available
    func adView(_ view: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        hideBanner(adMobBannerView)
    }
}
