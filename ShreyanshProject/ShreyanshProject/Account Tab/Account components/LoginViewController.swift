//
//  LoginViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 26/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import FBSDKLoginKit
import FirebaseAuth



class LoginViewController: UIViewController {

    @IBOutlet weak var emailIDLoginTextField: UITextField!
    @IBOutlet weak var passwordLoginTextField: UITextField!
    @IBOutlet weak var forgetPasswordLabel: UILabel!
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        emailIDLoginTextField.becomeFirstResponder()
        
        //This is code to make Forget Password Label clickable and in action we can perform clickable task
        let forgetPasswordLabelTap = UITapGestureRecognizer(target: self, action: #selector(forgetPasswordAction))
        
        forgetPasswordLabel.isUserInteractionEnabled = true
        forgetPasswordLabel.addGestureRecognizer(forgetPasswordLabelTap)
        
        
        
        if let token = AccessToken.current,
            !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            
            print("UserID: \(token.userID)")
        
        }
        
        
    }
    
    @IBAction func manualLoginAction(_ sender: UIButton) {
        
        let retrievedEmail: String? = KeychainWrapper.standard.string(forKey: "userEmail")
        let retrievedPassword: String? = KeychainWrapper.standard.string(forKey: "userPassword")

        
        guard let emailID = emailIDLoginTextField.text, let password = passwordLoginTextField.text else { return  }
        
        if emailID == retrievedEmail && password == retrievedPassword {
            
            self.dismiss(animated: true, completion: nil)
            
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("UserLoginSuccessFully"), object: nil)
            
        }
                
    }
    
    
    
    @IBAction func facebookLoginAction(_ sender: UIButton) {
        
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            
            print(accessToken)
            
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                
                if let error = error {
                    print("Facebook authentication with Firebase error: ", error)
                    return
                }
                
                print("Login success!")
                
                
            }
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

