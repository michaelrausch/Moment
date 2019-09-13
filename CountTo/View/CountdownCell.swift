//
//  CountdownCell.swift
//  CountTo
//
//  Created by Michael Rausch on 13/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import UIKit

class CountdownCell: UITableViewCell, CountdownTimerDelegate {
    private let GRADIENT_BLUE = [UIColor(red: 79/255, green: 172/255, blue: 254/255, alpha: 1).cgColor, UIColor(red: 0/255, green: 242/255, blue: 254/255, alpha: 1).cgColor]
    
    private let GRADIENT_RED = [UIColor(red: 250/255, green: 112/255, blue: 154/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 140/255, blue: 160/255, alpha: 1).cgColor]
    
    private let GRADIENT_GREEN = [UIColor(red: 67/255, green: 233/255, blue: 123/255, alpha: 1).cgColor, UIColor(red: 70/255, green: 230/255, blue: 80/255, alpha: 1).cgColor]
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timeUntilEvent: UILabel!
    @IBOutlet weak var contentContainer: UIView!
    
    private var countdownTimer: CountdownTimer? = nil
    private var event: Event? = nil
    private var daysLeft: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countdownTimer = CountdownTimer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(event: Event) {
        self.event = event

        title.text = event.eventName
        timeUntilEvent.text = ""
        
        if let countdownTimer = self.countdownTimer {
            countdownTimer.setDate(to: event.eventTime)
            countdownTimer.delegate = self
            countdownTimer.startUpdating()
            daysLeft = countdownTimer.getDaysUntilEvent()
        }
        
        applyStyles()
    }
    
    /**
     Apply styling for the table view cell
     */
    func applyStyles() {
        contentContainer.layer.cornerRadius = 5
        contentContainer.layer.masksToBounds = true
        
        // Apply gradient
        let gradient = CAGradientLayer()

        gradient.frame = contentContainer.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)

        if daysLeft > 20 {
            gradient.colors = GRADIENT_RED
        }
        
        else if daysLeft > 3 {
            gradient.colors = GRADIENT_BLUE
        }
        
        else {
            gradient.colors = GRADIENT_GREEN
        }
        
        contentContainer.layer.insertSublayer(gradient, at: 0)
    }

    /**
     Delegate method to recieve updates from the countdown timer.
     This will update the timer once per second.
     
     - Parameter timeString: The time until the event formatted as a string e.g "1 Hour 5 Minutes 20 Seconds"
     */
    func update(timeString: String) {
        timeUntilEvent.text = timeString
        
        applyStyles()
    }
}
