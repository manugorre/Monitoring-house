//
//  MainTabBarController.swift
//  Monitoring
//
//  Created by Emmanuel GORRE on 12/05/2017.
//  Copyright © 2017 Emmanuel Gorre. All rights reserved.
//

import UIKit
import Alamofire

class MainNavigationController: UINavigationController {

    
    
    // MARK: Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if !isServerReachable() {
            //navigationController?.present(String(description: "NoSonosViewController"), animated: true, completion: nil)
        }
    }
    
    func isServerReachable() -> Bool {
        let manager = NetworkReachabilityManager(host: Webservice.baseURL)
        
        if let isReachable = manager?.isReachableOnWWAN {
            return isReachable
        }
        
        return false
    }
}
