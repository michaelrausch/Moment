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
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imagePickerCollectionView: BackgroundImagePickerCV!

    var modalHandlerDelegate: ModalHandlerDelegate?
    var event = Event()
    let repo = EventRepositoryDatabase()
    let notificationManager = NotificationManager()

    var selectedImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        update()
    }
    
    func setup() {
        eventNameTextBox.addTarget(self, action: #selector(EventDetailsVC.eventNameTextChanged(_:)), for: UIControl.Event.editingChanged)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        imagePickerCollectionView.imagePickerDelegate = self
    }

    func setEvent(event: Event) {
        self.event = event // Set the event to edit
    }
    
    func update() {
        eventNameTextBox.text = event.eventName
        datePicker.date = event.eventTime
        selectedImage = event.imageName
        imagePickerCollectionView.setInitialImage(image: selectedImage)
        updateCharacterCountLabel()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        updateEvent()
        prepareForDismiss()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        notificationManager.cancelNotification(id: event.id)
        repo.delete(event: event)
        prepareForDismiss()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateEvent() {
        let updatedEvent = Event()
        updatedEvent.eventName = eventNameTextBox.text ?? "Event"
        updatedEvent.eventTime = datePicker.date
        updatedEvent.id = event.id
        updatedEvent.imageName = selectedImage

        repo.update(event: updatedEvent)
        
        // Update notification by scheduling another one with the same ID
        notificationManager.scheduleNotification(id: updatedEvent.id, title: updatedEvent.eventName, body: "It's time for \(updatedEvent.eventName)!", date: datePicker.date)
    }
    
    func updateCharacterCountLabel() {
        if let charCount = eventNameTextBox.text?.count {
            characterCountLabel.text = "\(charCount)/\(Const.FORM_FIELD_MAX_CHAR_COUNT)"
        }
    }

    @objc func eventNameTextChanged(_ textField: UITextField) {
       updateCharacterCountLabel()
    }
    
    func prepareForDismiss() {
        if let delegate = modalHandlerDelegate {
            delegate.modalDismissed()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension EventDetailsVC: BackgroundImagePickerDelegate {
    func imageSelected(with name: String) {
        selectedImage = name
    }
}
