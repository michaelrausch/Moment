//
//  TabBarVC.swift
//  CountTo
//
//  Created by Michael Rausch on 11/04/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        removeTopBorder()
    }
    
    func removeTopBorder() {
        if #available(iOS 13, *) {
            // iOS 13:
            let appearance = tabBar.standardAppearance
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            appearance.backgroundColor = UIColor.systemGray6
            tabBar.standardAppearance = appearance
        } else {
            // iOS 12 and below:
            tabBar.shadowImage = UIImage()
        }

    }
}
