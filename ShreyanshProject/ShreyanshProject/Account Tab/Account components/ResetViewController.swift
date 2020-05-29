//
//  ResetViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 29/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class ResetViewController: UIViewController {
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func setPasswordAction(_ sender: UIButton) {
        
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
        
        if let password = passwordTextField.text {
            KeychainWrapper.standard.set(password, forKey: "userPassword")
            
            print("Save was successful")
            self.view.endEditing(true)
        }
        
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("openLoginView"), object: nil)
        
    }
    
    
    func showAlertMsg(msg: String) {
        
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
