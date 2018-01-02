//
//  AdMobConfig.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 12/28/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import Foundation
import UIKit

class AdMobConfig {
    var bannerId: String?
    var appId: String?
    
    init() {
        var keys: NSDictionary?
        let path = Bundle.main.path(forResource: "Keys", ofType: "plist")
        keys = NSDictionary(contentsOfFile: path!)
        self.appId = keys!["APPLICATION_ID"] as? String
        self.bannerId = keys!["ADMOB_BANNER_UNIT_ID"] as? String
    }
}
