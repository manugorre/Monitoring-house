//
//  Utils.swift
//  Monitoring
//
//  Created by Emmanuel Gorre on 03/05/2017.
//  Copyright © 2017 Emmanuel Gorre. All rights reserved.
//

import UIKit
import Alamofire



class Utils: NSObject {
    
    static func isReachable(host: String) -> Bool {
        let reachability = NetworkReachabilityManager(host: host)
        
        if let isReachable = reachability?.isReachable {
            return isReachable
        }
        
        return false
    }
}
