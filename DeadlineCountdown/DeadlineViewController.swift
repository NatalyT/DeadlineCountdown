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
import GoogleMobileAds
import AudioToolbox

class DeadlineViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var deadlineLabel: InsetLabel!
    @IBOutlet weak var dateTitleLabel: InsetLabel!
    
   /* @IBAction func crashButtonTapped(_ sender: AnyObject) {
        Crashlytics.sharedInstance().crash()
    }
    */
    
    private var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    var selectedDate: DeadlineItems?
    
    // Ad banner and interstitial views
    var adMobBannerView: GADBannerView!
    let ADMOB_BANNER_UNIT_ID = "ca-app-pub-9691910327507240/6202482590"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init AdMob banner
        initAdMobBanner()
        
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
    }
    */

    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // MARK: -  ADMOB BANNER
    func initAdMobBanner() {
        /*
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
         adMobBannerView.load(request)*/
        
        // Instantiate the banner view with your desired banner size.
        adMobBannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(adMobBannerView)
        adMobBannerView.rootViewController = self
        // Set the ad unit ID to your own ad unit ID here.
        adMobBannerView.adUnitID = ADMOB_BANNER_UNIT_ID
        
        //adMobBannerView.load(GADRequest())
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        adMobBannerView.load(request)
    }
    
    func addBannerViewToView(_ bannerView: UIView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        if #available(iOS 11.0, *) {
            positionBannerAtBottomOfSafeArea(bannerView)
        }
        else {
            positionBannerAtBottomOfView(bannerView)
        }
    }
    
    @available (iOS 11, *)
    func positionBannerAtBottomOfSafeArea(_ bannerView: UIView) {
        // Position the banner. Stick it to the bottom of the Safe Area.
        // Centered horizontally.
        let guide: UILayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate(
            [bannerView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
             bannerView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)]
        )
    }
    
    func positionBannerAtBottomOfView(_ bannerView: UIView) {
        // Center the banner horizontally.
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .centerX,
                                              multiplier: 1,
                                              constant: 0))
        // Lock the banner to the top of the bottom layout guide.
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: self.bottomLayoutGuide,
                                              attribute: .top,
                                              multiplier: 1,
                                              constant: 0))
    }
    
}

