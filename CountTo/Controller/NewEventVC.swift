//
//  NewEventVC.swift
//  CountTo
//
//  Created by Michael Rausch on 13/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import UIKit

class NewEventVC: UIViewController {
    let repo = EventRepositoryDatabase()
    var delegate: ModalHandlerDelegate? = nil
    
    @IBOutlet weak var eventNameInput: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventNameInput.becomeFirstResponder()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        view.addGestureRecognizer(tap)
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        let event = Event()
        event.eventName = eventNameInput.text ?? ""
        event.eventTime = datePicker.date
        
        repo.create(event: event)
        
        if delegate != nil {
            delegate?.modalDismissed()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
