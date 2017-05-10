//
//  Sound.swift
//  Monitoring
//
//  Created by Emmanuel Gorre on 01/05/2017.
//  Copyright © 2017 Emmanuel Gorre. All rights reserved.
//

import UIKit

class Sound: NSObject {
    
    var id: Int = 0
    var authorId: Int = 0
    var title: String?
    
    override init() {}
    
    init(jsonData: [String: AnyObject]) {
    
        if let id = jsonData["id"] as? Int {
            self.id = id
        }
        
        if let authorId = jsonData["author_id"] as? Int {
            self.authorId = authorId
        }
        
        if let title = jsonData["title_text"] as? String {
            self.title = title
        }
    }
}
