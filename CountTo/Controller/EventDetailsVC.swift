//
//  EventDetailsVC.swift
//  CountTo
//
//  Created by Michael Rausch on 13/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import UIKit

class EventDetailsVC: UIViewController {
    @IBOutlet weak var eventNameTextBox: LargeTransparentTextField!
    
    var delegate: ModalHandlerDelegate?
    var event = Event()
    let repo = EventRepositoryDatabase()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        view.addGestureRecognizer(tap)

        update()
    }

    func setup(event: Event) {
        self.event = event
    }
    
    func update() {
        eventNameTextBox.text = event.eventName
        datePicker.date = event.eventTime
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let updatedEvent = Event()
        updatedEvent.eventName = eventNameTextBox.text ?? "Event"
        updatedEvent.eventTime = datePicker.date
        updatedEvent.id = event.id

        repo.update(event: updatedEvent)
        prepareForDismiss()
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        repo.delete(event: event)
        prepareForDismiss()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func datePickerUpdated(_ sender: Any) {
        
    }
    
    func prepareForDismiss() {
        if delegate != nil {
            delegate?.modalDismissed()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
