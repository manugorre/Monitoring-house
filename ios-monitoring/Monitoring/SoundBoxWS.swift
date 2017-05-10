//
//  SoundWS.swift
//  Monitoring
//
//  Created by Emmanuel Gorre on 01/05/2017.
//  Copyright © 2017 Emmanuel Gorre. All rights reserved.
//

import UIKit
import Alamofire

class SoundBoxWS: Webservice {
    
    static let soundPath = "soundbox/"
    static let listenPath = "listen/"
    
    class func getSoundBox(completion: @escaping ([[Sound]], [Author]) -> Void) {
        let URLString = URLStringForPath(path: String(format: soundPath))
        
        Alamofire.request(URLString).validate().responseJSON { response in
            var soundList = [[Sound]()]
            var authorList = [Author]()
            
            guard response.result.isSuccess else {
                print("Error while fetching remote sound")
                completion([[Sound]()], [Author]())
                return
            }
            
            guard let soundboxJSON = response.result.value as? [String: AnyObject] else {
                print("Malformed data received from getSoundBox service")
                completion([[Sound]()], [Author]())
                return
            }
            
            if let soundsGroupesJSON = soundboxJSON["sounds"] as? [[[String: AnyObject]]] {
                
                for soundsJSON in soundsGroupesJSON {
                    
                    var sounds: [Sound] = []
                    for soundJSON in soundsJSON {
                        sounds.append(Sound(jsonData: soundJSON))
                    }
                    
                    soundList.append(sounds)
                }
                soundList.remove(at: 0)
            }
            
            if let authorsJSON = soundboxJSON["authors"] as? [[String: AnyObject]] {
                
                authorList = authorsJSON.flatMap({ (authorDict) -> Author? in
                    return Author(jsonData: authorDict)
                })
            }

            completion(soundList, authorList)
        }
    }
    
    class func listenSound(speakerId: String, soundId: Int, completion: @escaping (Void) -> Void) {
        let URLString = URLStringForPath(path: String(format: listenPath))
        let parameters = ["speaker_id": speakerId, "sound_id": soundId] as [String : Any]
        
        Alamofire.request(URLString, parameters: parameters).validate().responseJSON { response in
            
            guard response.result.isSuccess else {
                print("Error while fetching remote sonos")
                completion()
                return
            }
            
            completion()
        }
    }
}

