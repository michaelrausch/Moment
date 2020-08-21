//
//  NewEventVC.swift
//  CountTo
//
//  Created by Michael Rausch on 13/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import UIKit

class NewEventVC: UIViewController, BackgroundImagePickerDelegate {
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var eventNameInput: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var backgroundImagePicker: BackgroundImagePickerCV!

    let repo = EventRepositoryDatabase()
    let notificationManager = NotificationManager()
    var delegate: ModalHandlerDelegate? = nil
    var selectedImage: String = "bluegradient"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        notificationManager.requestAuthorization()
    }
    
    func setup() {
        eventNameInput.becomeFirstResponder()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        backgroundImagePicker.imagePickerDelegate = self
        
        eventNameInput.addTarget(self, action: #selector(NewEventVC.eventNameTextChanged(_:)), for: UIControl.Event.editingChanged)
        
        updateCharacterCountLabel()
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let event = Event()
        event.eventName = eventNameInput.text ?? ""
        event.eventTime = datePicker.date
        event.imageName = selectedImage
        
        repo.create(event: event)
        
        if delegate != nil {
            delegate?.modalDismissed()
        }
        
        notificationManager.scheduleNotification(id: event.id, title: event.eventName, body: "It's time for \(event.eventName)!", date: datePicker.date)
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
 
    @objc func eventNameTextChanged(_ textField: UITextField) {
        updateCharacterCountLabel()
    }

    func imageSelected(with name: String) {
        selectedImage = name
    }
    
    func updateCharacterCountLabel() {
        if let charCount = eventNameInput.text?.count {
            characterCountLabel.text = "\(charCount)/\(Const.FORM_FIELD_MAX_CHAR_COUNT)"
        }
    }
}
