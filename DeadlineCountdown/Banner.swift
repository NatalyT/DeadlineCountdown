//
//  AdMobBannerInitialisation.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 12/16/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds
import AudioToolbox

class Banner {
    
    // MARK: -  ADMOB BANNER
    
    class func load(adMobBannerView: GADBannerView, viewController: UIViewController) {
        // Ad banner and interstitial views
        //let adMobBannerView = GADBannerView()
        let ADMOB_BANNER_UNIT_ID = "ca-app-pub-9691910327507240/6202482590"
        let adMobSize = Banner().size()
        
        adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: adMobSize.width, height: adMobSize.height))
        adMobBannerView.adUnitID = ADMOB_BANNER_UNIT_ID
        adMobBannerView.rootViewController = viewController
        adMobBannerView.delegate = viewController as? GADBannerViewDelegate
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        adMobBannerView.load(request)
    }
    
    class func size() -> (height: Int, width: Int) {
        var width = 320
        var height = 50
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            width = 468
            height = 60
        }
        
        return (height: height, width: width)
    }
}
