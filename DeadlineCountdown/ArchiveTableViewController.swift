//
//  ArchiveTableViewController.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 12/8/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds
import AudioToolbox

class ArchiveTableViewController: UITableViewController, GADBannerViewDelegate {
    
    var storedDatesArray: [DeadlineItems] = []
    
    // Ad banner and interstitial views
    var adMobBannerView = GADBannerView()
    let ADMOB_BANNER_UNIT_ID = "ca-app-pub-9691910327507240/6202482590"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        storedDatesArray = DeadlineItems.all(status: NSNumber(value: true))
        storedDatesArray = storedDatesArray.sorted(by: { $0.date?.compare($1.date!) == .orderedAscending })
        tableView.reloadData()
        // Init AdMob banner
        initAdMobBanner()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "archivedCell", for: indexPath) as UITableViewCell
        
        let dateTitle = storedDatesArray[indexPath.row].dateTitle!
        let date = storedDatesArray[indexPath.row].date!
        
        if date < Date() {
            cell.textLabel?.textColor = UIColor.lightGray
            cell.detailTextLabel?.textColor = UIColor.lightGray
        }
        
        cell.textLabel?.text = dateTitle
        
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        
        cell.detailTextLabel?.text = formatter.string(from: date)
        
        return cell
    }
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     self.performSegue(withIdentifier: "segueToDeadlineVC", sender: indexPath)
     }*/
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return adMobBannerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return adMobBannerView.frame.height
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action:UITableViewRowAction, indexPath:IndexPath) in
            let idn = self.storedDatesArray[indexPath.row].eventIdentificator
            CalendarEvents().removeEvent(savedEventId: idn!)
            self.storedDatesArray[indexPath.row].delete()
            self.storedDatesArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        delete.backgroundColor = .red
        
        let restore = UITableViewRowAction(style: .default, title: "Restore") { (action:UITableViewRowAction, indexPath:IndexPath) in
            self.storedDatesArray[indexPath.row].archive(archivedStatus: false)
            self.storedDatesArray[indexPath.row].archived = false
            self.storedDatesArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        restore.backgroundColor = .magenta
        
        let date = storedDatesArray[indexPath.row].date!
        if date > Date() {
            return [delete, restore]
        } else {
            return [delete]
        }
    }
    
    // MARK: -  ADMOB BANNER
    func initAdMobBanner() {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            // iPhone
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
        } else  {
            // iPad
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 468, height: 60))
        }
        
        adMobBannerView.adUnitID = ADMOB_BANNER_UNIT_ID
        adMobBannerView.rootViewController = self
        adMobBannerView.delegate = self
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        adMobBannerView.load(request)
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Banner loaded successfully")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Fail to receive ads")
        print(error)
    }
}

