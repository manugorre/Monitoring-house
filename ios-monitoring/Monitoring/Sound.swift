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
    
    init(JSON: [String: AnyObject]) {
    
        if let id = JSON["id"] as? Int {
            self.id = id
        }
        
        if let authorId = JSON["author_id"] as? Int {
            self.authorId = authorId
        }
        
        if let title = JSON["title_text"] as? String {
            self.title = title
        }
    }
}
