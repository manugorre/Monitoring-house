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
    
    init(jsonData: [String: AnyObject]) {
        
        if let id = jsonData["id"] as? Int {
            self.id = id
        }
        
        if let playerName = jsonData["player_name"] as? String {
            self.playerName = playerName
        }
        
        if let ipAddress = jsonData["ip_address"] as? String {
            self.ipAddress = ipAddress
        }
        
        if let modelName = jsonData["model_name"] as? String {
            self.modelName = modelName
        }
        
        if let playerIconPath = jsonData["player_icon_url"] as? String {
            let playerIconURL = "http://\(self.ipAddress!):1400\(playerIconPath)"
            self.playerIconURL = URL(string: playerIconURL)
        }
    }
}
