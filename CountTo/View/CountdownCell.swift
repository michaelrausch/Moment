//
//  CountdownCell.swift
//  CountTo
//
//  Created by Michael Rausch on 13/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import UIKit

class CountdownCell: UITableViewCell, CountdownTimerDelegate {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timeUntilEvent: UILabel!
    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
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
                
        backgroundImage.image = UIImage(named: event.imageName)
        
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
