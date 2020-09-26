//
//  SettingsVC.swift
//  CountTo
//
//  Created by Michael Rausch on 13/04/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import UIKit
import StoreKit

class SettingsVC: UIViewController, SKProductsRequestDelegate {
    @IBOutlet weak var cleanupToggle: UISwitch!
    @IBOutlet weak var remindersToggle: UISwitch!
    
    @IBOutlet weak var purchasePremiumButton: LargeButton!
    
    let productID = "nz.rausch.moment.premium"
    
    let settings = SettingManager()
    let notificationManager = NotificationManager()
    var productRequest: SKProductsRequest!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToggles()
        updatePremiumPrice()
        // Do any additional setup after loading the view.
    }
    
    func setupToggles() {
        if settings.isCleanupEnabled() {
            cleanupToggle.setOn(true, animated: true)
        }
        else {
            cleanupToggle.setOn(false, animated: true)
        }
        
        if settings.isRemindersEnabled() {
            remindersToggle.setOn(true, animated: true)
        }
        else {
            remindersToggle.setOn(false, animated: true)
        }
        
        if !settings.isPremiumEnabled() {
            remindersToggle.isEnabled = false
            cleanupToggle.isEnabled = false
        }
        else {
            remindersToggle.isEnabled = true
            cleanupToggle.isEnabled = true
        }
    }
    
    func showPurchaseAlert(premium: Bool) {
        var alertText = "You have purchased premium: SK Sandbox Purchase"
        
        if !premium {
            alertText = "You have cancelled premium"
        }
        
        let alert = UIAlertController(title: "Moment Premium", message: alertText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPrivacyWebView" {
            let controller = segue.destination as! WebViewVC
            controller.setup(name: "Privacy Policy", url: "https://michaelrausch.nz/privacy.txt")
        }
    }
    
    func updatePremiumPrice() {
        productRequest = SKProductsRequest(productIdentifiers: [productID])
        productRequest.delegate = self
        productRequest.start()
        print("HERE")
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if !response.products.isEmpty {
            let iAP = response.products.first!
            let formatter = NumberFormatter()
            formatter.locale = iAP.priceLocale
            formatter.numberStyle = .currency
            
            if let formattedAmount = formatter.string(from: iAP.price) {
                DispatchQueue.main.async { [weak self] in
                    self?.purchasePremiumButton.setTitle("Buy now for \(formattedAmount)", for: .normal)
                }
            }
        }

    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print(error)
    }
    
    @IBAction func premiumPurchaseClicked(_ sender: Any) {
        if settings.isPremiumEnabled() {
            settings.disablePremium()
            showPurchaseAlert(premium: false)
        }
        else {
            settings.enablePremium()
            showPurchaseAlert(premium: true)
        }
        setupToggles()
    }
    
    @IBAction func restorePurchasesPressed(_ sender: Any) {
        settings.enablePremium()
        showPurchaseAlert(premium: true)
        setupToggles()
    }
    
    @IBAction func cleanupToggleChanged1(_ sender: Any) {
        if cleanupToggle.isOn {
            settings.enableCleanup()
        }
        else {
            settings.disableCleanup()
        }
    }
    
    @IBAction func remindersToggleChanged(_ sender: Any) {
        if remindersToggle.isOn {
            settings.enableReminders()
            notificationManager.enableAllReminders()
        }
        else {
            settings.disableReminders()
            notificationManager.removeAllReminders()
        }
    }
    
    @IBAction func privacyPolicyPressed(_ sender: Any) {
        performSegue(withIdentifier: "showPrivacyWebView", sender: nil)
    }
}

