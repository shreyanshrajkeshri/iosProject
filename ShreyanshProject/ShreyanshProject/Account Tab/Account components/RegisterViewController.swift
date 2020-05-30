//
//  RegisterViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 26/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper


class RegisterViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailidTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        emailidTextField.becomeFirstResponder()
        
        signUpButton.layer.cornerRadius = 5
        
        showDatePicker()
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


    @IBAction func signUpAction(_ sender: UIButton) {
        
        if fullNameTextField.text!.isEmpty {
            showAlertMsg(msg: "Enter Full Name")
            return
        }
        
        if emailidTextField.text!.isEmpty {
            showAlertMsg(msg: "Enter Email Address")
            return
        }
        
        else if isValidEmail(emailidTextField.text!) == false{
            showAlertMsg(msg: "Invalid Email Address \n please Enter a valid Email ID")
            return
        }
        
        if passwordTextField.text != confirmPasswordTextField.text {
            showAlertMsg(msg: "Password Doesn't Match")
            return
        }
        
        if passwordTextField.text!.isEmpty {
            showAlertMsg(msg: "Enter Password")
            return
        }
        
        if isValidPassword(passwordTextField.text!) == false {
            showAlertMsg(msg: "Password should contain atleast \n 8 characters, 1 Uppercase, 1 Number and 1 Special Character")
            return
        }
        
        
        if let email = emailidTextField.text,
            let password = passwordTextField.text,
            let dateOfbirth = dateOfBirthTextField.text,
            let fullName = fullNameTextField.text {
            
            KeychainWrapper.standard.set(email, forKey: "userEmail")
            KeychainWrapper.standard.set(password, forKey: "userPassword")
            KeychainWrapper.standard.set(dateOfbirth, forKey: "userDOB")
            KeychainWrapper.standard.set(fullName, forKey: "userName")
            
            print("Save was successful")
            self.view.endEditing(true)
        }
        
     
    }
    
    
    func showAlertMsg(msg: String) {
        
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
   
}
