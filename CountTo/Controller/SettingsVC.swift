//
//  SettingsVC.swift
//  CountTo
//
//  Created by Michael Rausch on 13/04/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func premiumPurchaseClicked(_ sender: Any) {
        let settingManager = SettingManager()
        
        if settingManager.isPremiumEnabled() {
            settingManager.disablePremium()
            print("Disabled Premium")
        }
        else {
            settingManager.enablePremium()
            print("Enabled Premium")
        }
    }
}
