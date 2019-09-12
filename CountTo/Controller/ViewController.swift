//
//  ViewController.swift
//  CountTo
//
//  Created by Michael Rausch on 12/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var countdownTableView: UITableView!
        
    var events = [CountdownEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countdownTableView.dataSource = self
        countdownTableView.delegate = self
        
        countdownTableView.separatorStyle = .none
        
        let event1 = CountdownEvent(title: "Test Countdown", timeUntilEvent: "55 Days")
        events.append(event1)
        events.append(event1)
        events.append(event1)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = countdownTableView.dequeueReusableCell(withIdentifier: "countdownCell", for: indexPath) as? CountdownCell {
            
            let event = events[indexPath.row]
            cell.updateUI(event: event)
            cell.selectionStyle = .none
            
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.masksToBounds = true
    }

}

