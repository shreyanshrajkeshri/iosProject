//
//  LoginViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 26/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper


class LoginViewController: UIViewController {

    @IBOutlet weak var emailIDLoginTextField: UITextField!
    @IBOutlet weak var passwordLoginTextField: UITextField!
    @IBOutlet weak var forgetPasswordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        emailIDLoginTextField.becomeFirstResponder()
        
        //This is code to make Forget Password Label clickable and in action we can perform clickable task
        let forgetPasswordLabelTap = UITapGestureRecognizer(target: self, action: #selector(forgetPasswordAction))
        
        forgetPasswordLabel.isUserInteractionEnabled = true
        forgetPasswordLabel.addGestureRecognizer(forgetPasswordLabelTap)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        let retrievedEmail: String? = KeychainWrapper.standard.string(forKey: "userEmail")
        let retrievedPassword: String? = KeychainWrapper.standard.string(forKey: "userPassword")

        
        guard let emailID = emailIDLoginTextField.text, let password = passwordLoginTextField.text else { return  }
        
        if emailID == retrievedEmail && password == retrievedPassword {
            
            self.dismiss(animated: true, completion: nil)
            
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("UserLoginSuccessFully"), object: nil)
            
        }
                
    }
    
    @objc func forgetPasswordAction() {
        
        print("forgetPasswordLabelTap")
        
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("ForgetPassword"), object: nil)
               
    }
    
    func showAlertMsg(msg: String) {
        
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

