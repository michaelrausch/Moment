//
//  ViewController.swift
//  CountTo
//
//  Created by Michael Rausch on 12/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import UIKit

class ViewEventsVC: UIViewController{
    @IBOutlet weak var addEventButton: UIBarButtonItem!
    @IBOutlet weak var countdownTableView: UITableView!
    
    var events = [Event]()
    var eventRepo: EventRepository = EventRepositoryDatabase()
    let notificationManager = NotificationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countdownTableView.dataSource = self
        countdownTableView.delegate = self
        countdownTableView.separatorStyle = .none
        reloadEvents()
    }
    
    func reloadEvents() {
        events = eventRepo.getAllSortedByDate()
    }
    
    func showPremiumAlert() {
        let alert = UIAlertController(title: "Premium", message: "You need to purchase premium to create more than 3 events", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEventDetails" {
            let event = sender as! Event
            let controller = segue.destination as! EventDetailsVC
            
            controller.modalHandlerDelegate = self
            controller.setEvent(event: event)
        }
        
        if segue.identifier == "newEvent" {
            let sm = SettingManager()
            
            if events.count >= 3 && !sm.isPremiumEnabled() {
                showPremiumAlert()
                return
            }
            
            let controller = segue.destination as! NewEventVC
            controller.delegate = self
        }
    }
}

// MARK: UIViewController methods
extension ViewEventsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if events.count == 0 {
            self.countdownTableView.setEmptyMessage("You have no upcoming events ;(")
        }
        else {
            self.countdownTableView.restore()
        }
        
        return events.count
    }
    
    // MARK: Event cell for row at
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
        cell.contentView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
    
        performSegue(withIdentifier: "showEventDetails", sender: event)
    }

    // MARK: Configure swipe actions for event list
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in

            let event = self.events[indexPath.row]
            
            self.notificationManager.cancelNotification(id: event.id)
            
            self.eventRepo.delete(event: event)
            self.reloadEvents()
            self.countdownTableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        delete.backgroundColor = UIColor.systemRed
        delete.image = UIImage(systemName: "trash")
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete])

        return swipeActions
    }
}

extension ViewEventsVC: ModalHandlerDelegate {
    func modalDismissed() {
        reloadEvents()
        countdownTableView.reloadData()
    }
}

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.gray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "System", size: 20)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }

    func restore() {
        self.backgroundView = nil
    }
}
