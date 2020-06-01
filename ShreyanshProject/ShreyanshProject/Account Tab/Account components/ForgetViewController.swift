//
//  ForgetViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 21/03/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class ForgetViewController: UIViewController {

    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var captchatextField: UITextField!
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        resetPasswordButton.layer.cornerRadius = 5
        
        showDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupTheme()
        
    }
    
    func setupTheme() {
        view.backgroundColor = Theme.color(type: .backgroundColor)
    }
    
    
    func showDatePicker() {
        
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)

         dateOfBirthTextField.inputAccessoryView = toolbar
         dateOfBirthTextField.inputView = datePicker
        
        
    }
    
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateOfBirthTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }

    
    @IBAction func getPasswordAction(_ sender: UIButton) {
        
        let retrievedDOB: String? = KeychainWrapper.standard.string(forKey: "userDOB")

        
        if let dateOfBirth = dateOfBirthTextField.text,
            let captcha = captchatextField.text {
            
            if dateOfBirth == retrievedDOB && captcha == "just example" {
                
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name("ResetPassword"), object: nil)
            }
            
            else if dateOfBirth != retrievedDOB {
                showAlertMsg(msg: "Wrong Date Of Birth")
            }
            
            else if captcha != "just example" {
                showAlertMsg(msg: "Wrong Captcha")
            }
        }
        
    }
    
    
    func showAlertMsg(msg: String) {
        
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    

}
