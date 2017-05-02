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
    
    init(JSON: [String: AnyObject]) {
        
        if let id = JSON["id"] as? Int {
            self.id = id
        }
        
        if let name = JSON["name_text"] as? String {
            self.name = name
        }
    }
}
