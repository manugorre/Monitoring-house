//
//  SoundTableViewCell.swift
//  Monitoring
//
//  Created by Emmanuel Gorre on 01/05/2017.
//  Copyright © 2017 Emmanuel Gorre. All rights reserved.
//

import UIKit

class SoundTableViewCell: UITableViewCell {
    
    @IBOutlet weak var soundTitle: UILabel!
    
    var sound: Sound? {
        didSet {
            updateTitle()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateTitle() {
        if let title = sound?.title {
            soundTitle.text = title
        }
    }
}
