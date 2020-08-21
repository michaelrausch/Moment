//
//  AboutVC.swift
//  CountTo
//
//  Created by Michael Rausch on 21/08/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import Foundation
import UIKit

class AboutVC: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! WebViewVC

        if segue.identifier == "showMyWebsite" {
            controller.setup(name: "Michael Rausch", url: "https://michaelrausch.nz")
        }
        
        if segue.identifier == "showTimWebsite" {
            controller.setup(name: "Tim Mangos", url: "https://www.instagram.com/timmangosphotography")
        }
        
        if segue.identifier == "showRealmWebsite" {
            controller.setup(name: "Realm", url: "https://realm.io")
        }
        
        if segue.identifier == "openBarberAndCo" {
            controller.setup(name: "Book A Cut", url: "https://barberco3.gettimely.com/Booking/Location/103815?mobile=True")
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
