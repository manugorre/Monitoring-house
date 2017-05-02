//
//  SonosWS.swift
//  Monitoring
//
//  Created by Emmanuel Gorre on 01/05/2017.
//  Copyright © 2017 Emmanuel Gorre. All rights reserved.
//

import UIKit
import Alamofire

class SonosWS: Webservice {
    
    static let sonosPath = "sonos/"

    class func getSonos(successClosure: @escaping ([Sonos]) -> Void, failureClosure: @escaping (NSError?) -> Void) {
        let URLString = URLStringForPath(path: String(format: sonosPath))

        Alamofire.request(URLString).validate().responseJSON { response in
            var sonosList = [Sonos]()
            
            if response.result.isSuccess {
                if let sonosListJSON = response.result.value as? [[String: AnyObject]] {
                    for sonosJSON in sonosListJSON {
                        sonosList.append(Sonos(JSON: sonosJSON))
                    }
                    successClosure(sonosList)
                }
            } else if response.result.isFailure {
                print(response.result.error!)
                failureClosure(response.result.error as NSError?)
            } else {
                failureClosure(nil)
            }
        }
    }
}
