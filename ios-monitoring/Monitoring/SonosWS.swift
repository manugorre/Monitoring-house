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

    class func getSonos(completion: @escaping ([Sonos]?) -> Void) {
        let URLString = URLStringForPath(path: String(format: sonosPath))

        Alamofire.request(URLString).validate().responseJSON { (response) -> Void in

            guard response.result.isSuccess else {
                print("Error while fetching remote sonos")
                completion([Sonos]())
                return
            }
            
            guard let rows = response.result.value as? [[String: AnyObject]] else {
                    completion([Sonos]())
                    return
            }
            
            let sonosList = rows.flatMap({ (sonosDict) -> Sonos? in
                return Sonos(jsonData: sonosDict)
            })
            
            completion(sonosList)
        }
    }
}
