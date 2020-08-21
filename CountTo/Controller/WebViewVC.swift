//
//  PrivacyPolicyVC.swift
//  CountTo
//
//  Created by Michael Rausch on 21/08/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewVC: UIViewController {
    @IBOutlet weak var webkitView: WKWebView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var website: String = ""
    private var name: String = ""
    
    override func viewDidLoad() {
        nameLabel.text = name
        let url = URL(string: self.website)
        let request = URLRequest(url: url!)
        webkitView.load(request)
    }
    
    func setup(name: String, url: String) {
        self.website = url;
        self.name = name;
    }
    
    @IBAction func openLinkPressed(_ sender: Any) {
        guard let url = URL(string: website) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
