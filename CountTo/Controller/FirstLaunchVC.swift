//
//  FirstLaunchVC.swift
//  CountTo
//
//  Created by Michael Rausch on 14/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import UIKit

class FirstLaunchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
