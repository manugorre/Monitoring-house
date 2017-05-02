//
//  WebService.swift
//  Monitoring
//
//  Created by Emmanuel Gorre on 01/05/2017.
//  Copyright © 2017 Emmanuel Gorre. All rights reserved.
//


import UIKit

import Alamofire

class Webservice: NSObject {
    
    static let devEnvironment = true
    static let baseURL = devEnvironment ? "http://192.168.0.22:8000/" : ""
    
    
    
    // MARK: API
    
    static func mutableURLRequestForPath(path: String) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: NSURL(string: URLStringForPath(path: path))! as URL)
        return request
    }
    
    static func URLStringForPath(path: String) -> String {
        print(baseURL + path)
        return baseURL + path
    }
    
    static func headers() -> [String: String] {
        let headers = ["X-Language": "fr"]
        
        return headers
    }
    
//    class func errorJSONFromResponse(response: Response<AnyObject, NSError>?) -> [String: AnyObject]? {
//        if let errorData = response?.data {
//            do {
//                if let errorJSON = try JSONSerialization.JSONObjectWithData(errorData, options: NSJSONReadingOptions.AllowFragments) as? [String: AnyObject] {
//                    return errorJSON
//                }
//            } catch _ {}
//        }
//        
//        return nil
//    }
    
}
