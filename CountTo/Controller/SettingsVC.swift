//
//  SettingsVC.swift
//  CountTo
//
//  Created by Michael Rausch on 13/04/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {    
    var settingManager = SettingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showPurchaseAlert(premium: Bool) {
        var alertText = "You have purchased premium: SK Reciept = SANDBOX4948210"
        
        if !premium {
            alertText = "You have cancelled premium"
        }
        
        let alert = UIAlertController(title: "Moment Premium", message: alertText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func premiumPurchaseClicked(_ sender: Any) {
        if settingManager.isPremiumEnabled() {
            settingManager.disablePremium()
            showPurchaseAlert(premium: false)
        }
        else {
            settingManager.enablePremium()
            showPurchaseAlert(premium: true)
        }
    }
}

