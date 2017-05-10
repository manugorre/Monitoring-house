//
//  Author.swift
//  Monitoring
//
//  Created by Emmanuel Gorre on 01/05/2017.
//  Copyright © 2017 Emmanuel Gorre. All rights reserved.
//

import UIKit

class Author: NSObject {
    
    var id: Int = 0
    var name: String?
    
    override init() {}
    
    init(jsonData: [String: AnyObject]) {
        
        if let id = jsonData["id"] as? Int {
            self.id = id
        }
        
        if let name = jsonData["name_text"] as? String {
            self.name = name
        }
    }
}
