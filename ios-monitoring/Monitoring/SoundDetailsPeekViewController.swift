//
//  SoundDetailsPeekViewController.swift
//  Monitoring
//
//  Created by Emmanuel Gorre on 02/05/2017.
//  Copyright © 2017 Emmanuel Gorre. All rights reserved.
//

import UIKit

class SoundDetailsPeekViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    

    
    var sound: Sound? {
        didSet {
            
        }
    }
    
    var author: Author? {
        didSet {
            
        }
    }
    
    
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateTitle()
        updateName()
    }
    
    
    
    // MARK: Update
    
    func updateTitle() {
        if let title = sound?.title {
            titleLabel.text = title
        }
    }
    
    func updateName() {
        if let name = author?.name {
            authorLabel.text = name
        }
    }
}
