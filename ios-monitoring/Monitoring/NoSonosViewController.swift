//
//  NoSonosViewController.swift
//  Monitoring
//
//  Created by Emmanuel GORRE on 12/05/2017.
//  Copyright © 2017 Emmanuel Gorre. All rights reserved.
//

import UIKit
import SDWebImage

class NoSonosViewController: UIViewController {
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    override func viewDidLoad() {
        initGif()
    }
    
    func initGif() {
        gifImageView.sd_setImage(with: URL(string: "https://media4.giphy.com/media/jWexOOlYe241y/giphy.gif"))
    }
}
