//
//  SoundDetailsPeekViewController.swift
//  Monitoring
//
//  Created by Emmanuel Gorre on 02/05/2017.
//  Copyright © 2017 Emmanuel Gorre. All rights reserved.
//

import UIKit

class SoundDetailsPeekViewController: UIViewController {
    
    
    
    var author: Author? {
        didSet {
            print(author?.name)
        }
    }
    
    var sound: Sound? {
        didSet {
            print(sound?.title)
        }
    }
    
    
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
