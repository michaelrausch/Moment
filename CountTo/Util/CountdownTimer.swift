//
//  CountdownTimer.swift
//  CountTo
//
//  Created by Michael Rausch on 13/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import Foundation

class CountdownTimer {
    private var countdownDate: Date?
    private var countdownDateComponents: DateComponents? = nil
    private let calendar: Calendar
    private var timer: Timer? = nil
    
    var delegate: CountdownTimerDelegate? = nil
    
    init() {
        calendar = Calendar.current
    }
    
    /**
     Set the date to countdown to
     
     - Parameter to: The date to count down to
     */
    func setDate(to date: Date) {
        countdownDate = date

        countdownDateComponents = calendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
    }
    
    /**
     Get the difference between now and the countdown date
     
     - Returns: The difference between now and the countdown date, or nil
                if no countdown date has been set
     */
    private func getTimeDifference() -> DateComponents? {
        let now = calendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: Date())
        
        guard let countdownDateComponents = countdownDateComponents else {
            return nil
        }
        
        return calendar.dateComponents([.day, .hour, .minute, .second], from: now, to: countdownDateComponents)
    }
    
    /**
     Gets the number of days until the event
     
     - Returns: The number of days until the event
     */
    func getDaysUntilEvent() -> Int{
        guard let timeDifference = getTimeDifference() else {
            return 0
        }
        
        return timeDifference.day ?? 0
    }
    
    /**
     Get a string representation of the time until the countdown date.
     
     The string will be in the format "x Days y Hours z Minutes" unless there is
     less than 24 hours until the event in which case the format will be
     "x Hours y Minutes z Seconds". If the event has occured, this will
     return "Event Happened"
     
     - Returns: A countdown to the event date
     */
    func getTimeString() -> String{
        var timeString = ""
        
        guard let difference = getTimeDifference() else {
            return ""
        }
        
        let days = difference.day ?? 0
        let hours = difference.hour ?? 0
        let minutes = difference.minute ?? 0
        let seconds = difference.second ?? 0
        
        if days < 0 || hours < 0 || minutes < 0 || seconds < 0 {
            return "Event Happened"
        }
        
        if days > 0 {
            timeString += "\(days) Days "
        }
        
        timeString +=  "\(hours) Hours \(minutes) Minutes "
        
        if days == 0 {
            timeString += "\(seconds) Seconds"
        }
        
        return timeString
    }
    
    /**
     Starts the timer which calls the delegates update(timeString:) method every second
     */
    func startUpdating() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateTimer() {
        if delegate != nil {
            delegate?.update(timeString: getTimeString())
        }
    }
}
