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
    
    class func getSoundBox(successClosure: @escaping ([[Sound]], [Author]) -> Void, failureClosure: @escaping (NSError?) -> Void) {
        let URLString = URLStringForPath(path: String(format: soundPath))
        
        Alamofire.request(URLString).validate().responseJSON { response in
            var soundList = [[Sound]()]
            var authorList = [Author]()
            
            if response.result.isSuccess {
                if let soundboxJSON = response.result.value as? [String: AnyObject] {
                    
                    if let soundsGroupesJSON = soundboxJSON["sounds"] as? [[[String: AnyObject]]] {
                        
                        for soundsJSON in soundsGroupesJSON {

                            var sounds: [Sound] = []
                            for soundJSON in soundsJSON {
                                sounds.append(Sound(JSON: soundJSON))
                            }
                            
                            soundList.append(sounds)
                        }
                        soundList.remove(at: 0)
                    }

                    if let authorsJSON = soundboxJSON["authors"] as? [[String: AnyObject]] {
                        
                        for authorJSON in authorsJSON {
                            authorList.append(Author(JSON: authorJSON))
                        }
                    }
                    successClosure(soundList, authorList)
                }
            } else if response.result.isFailure {
                failureClosure(response.result.error as NSError?)
            } else {
                failureClosure(nil)
            }
        }
    }
    
    class func listenSound(speakerId: String, soundId: Int, successClosure: @escaping (Void) -> Void, failureClosure:  @escaping (NSError?) -> Void) {
        let URLString = URLStringForPath(path: String(format: listenPath))
        let parameters = ["speaker_id": speakerId, "sound_id": soundId] as [String : Any]
        
        Alamofire.request(URLString, parameters: parameters).validate().responseJSON { response in
            if response.result.isSuccess {
                successClosure()
            } else if response.result.isFailure {
                failureClosure(response.result.error as NSError?)
            } else {
                failureClosure(nil)
            }
        }
    }
}

