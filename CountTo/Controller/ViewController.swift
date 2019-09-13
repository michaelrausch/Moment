//
//  ViewController.swift
//  CountTo
//
//  Created by Michael Rausch on 12/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ModalHandlerDelegate{

    @IBOutlet weak var addEventButton: UIBarButtonItem!
    @IBOutlet weak var countdownTableView: UITableView!
        
    var events = [Event]()
    var eventRepo: EventRepository = EventRepositoryDatabase()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countdownTableView.dataSource = self
        countdownTableView.delegate = self
        countdownTableView.separatorStyle = .none
        
        events = eventRepo.getAll()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
    
        performSegue(withIdentifier: "showEventDetails", sender: event)
    }
                
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in

            let event = self.events[indexPath.row]
            
            self.eventRepo.delete(event: event)
            self.events = self.eventRepo.getAll()
            self.countdownTableView.deleteRows(at: [indexPath], with: .fade)

        }
        
        delete.backgroundColor = UIColor(white: 1, alpha: 0.00)
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete])

        return swipeActions
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showEventDetails" {
            let event = sender as! Event

            let controller = segue.destination as! EventDetailsVC
            controller.delegate = self
            controller.setup(event: event)
        }
        
        if segue.identifier == "newEvent" {
            let controller = segue.destination as! NewEventVC
            controller.delegate = self
        }
    }
    
    /**
     This delegate method is called as a modal is being dismissed. The tableview
     should be updated here
     */
    func modalDismissed() {
        events = eventRepo.getAll()
        countdownTableView.reloadData()
    }

}

