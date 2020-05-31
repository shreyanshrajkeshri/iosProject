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
import GoogleSignIn



class LoginViewController: UIViewController{

    @IBOutlet weak var emailIDLoginTextField: UITextField!
    @IBOutlet weak var passwordLoginTextField: UITextField!
    @IBOutlet weak var forgetPasswordLabel: UILabel!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var manualLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    
    
    let nc = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        emailIDLoginTextField.becomeFirstResponder()
        
        //This is code to make Forget Password Label clickable and in action we can perform clickable task
        let forgetPasswordLabelTap = UITapGestureRecognizer(target: self, action: #selector(forgetPasswordAction))
        
        forgetPasswordLabel.isUserInteractionEnabled = true
        forgetPasswordLabel.addGestureRecognizer(forgetPasswordLabelTap)
        
        
        manualLoginButton.layer.cornerRadius = 5
        
        
        if let token = AccessToken.current,
            !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            
            print("UserID: \(token.userID)")
        
        }
       
        //Google Restore Previous SignIn
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
    }
    
    @IBAction func googleLoginButton(_ sender: UIButton) {
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    
    @IBAction func manualLoginAction(_ sender: UIButton) {
        
        let retrievedEmail: String? = KeychainWrapper.standard.string(forKey: "userEmail")
        let retrievedPassword: String? = KeychainWrapper.standard.string(forKey: "userPassword")

        
        guard let emailID = emailIDLoginTextField.text, let password = passwordLoginTextField.text else { return  }
        
        if emailID == retrievedEmail && password == retrievedPassword {
            
            self.dismiss(animated: true, completion: nil)
            
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
            self.dismiss(animated: true, completion: nil)
            self.nc.post(name: Notification.Name("UserLoginSuccessFully"), object: nil)
                        
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                
                if let error = error {
                    print("Facebook authentication with Firebase error: ", error)
                    return
                }
                
                print("FaceBook Login SuccessFull!")
                loginMode = .facebook
                
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



extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                let authError = error as NSError
            }
            else {
                return
            }
            return
        }
        // User is signed in
        // ...
        
        print("Gooogle Login SuccessFull!")
        
        if let userName = user.profile.givenName {
            googleUserName =  userName
            
        }
        
        loginMode = .google
        
        self.dismiss(animated: true, completion: nil)
        nc.post(name: Notification.Name("UserLoginSuccessFully"), object: nil)
    }
    
    
}
