//
//  Sonos.swift
//  Monitoring
//
//  Created by Emmanuel Gorre on 01/05/2017.
//  Copyright © 2017 Emmanuel Gorre. All rights reserved.
//

import UIKit

class Sonos: NSObject {
    
    var id: Int = 0
    var playerName: String?
    var isSelected: Bool = false
    var ipAddress: String?
    var modelName: String?
    var playerIconURL: URL?
    
    override init() {}
    
    init(JSON: [String: AnyObject]) {
        
        if let id = JSON["id"] as? Int {
            self.id = id
        }
        
        if let playerName = JSON["player_name"] as? String {
            self.playerName = playerName
        }
        
        if let isSelected = JSON["is_selected"] as? Int {
            //self.isSelected = isSelected
        }
        
        if let ipAddress = JSON["ip_address"] as? String {
            self.ipAddress = ipAddress
        }
        
        if let modelName = JSON["model_name"] as? String {
            self.modelName = modelName
        }
        
        if let playerIconPath = JSON["player_icon_url"] as? String {
            let playerIconURL = "http://\(self.ipAddress!):1400\(playerIconPath)"
            self.playerIconURL = URL(string: playerIconURL)
        }
    }
}
