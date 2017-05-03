//
//  UIApplicationExtension.swift
//  Monitoring
//
//  Created by Emmanuel Gorre on 03/05/2017.
//  Copyright © 2017 Emmanuel Gorre. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
