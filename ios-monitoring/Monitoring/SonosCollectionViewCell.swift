//
//  SonosCollectionViewCell.swift
//  Monitoring
//
//  Created by Emmanuel Gorre on 01/05/2017.
//  Copyright © 2017 Emmanuel Gorre. All rights reserved.
//

import UIKit
import SDWebImage

class SonosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var playerIconImageView: UIImageView!
    @IBOutlet weak var vibrancyEffect: UIVisualEffectView!
    @IBOutlet weak var viewOverBlur: UIView!
    @IBOutlet weak var selectedView: UIView!
    
    var sonos: Sonos? {
        didSet {
            updateSonosTitleLabel()
            updateSonosModelLabel()
            updateSonosImage()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            
            
            UIView.animate(withDuration: 0.2) {
                self.vibrancyEffect.backgroundColor = self.isSelected ? UIColor.white : nil
                self.viewOverBlur.alpha = self.isSelected ? 1 : 0.5
                
                self.selectedView.isHidden = self.isSelected ? false : true
            }
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateSonosTitleLabel() {
        if let playerName = sonos?.playerName {
            titleLabel.text = playerName
        }
    }
    
    func updateSonosModelLabel() {
        if let modelName = sonos?.modelName {
            modelLabel.text = modelName
        }
    }
    
    func updateSonosImage() {
        if let playerIconURL = sonos?.playerIconURL {
            playerIconImageView.sd_setImage(with: playerIconURL, placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
}
