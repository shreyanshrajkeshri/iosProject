//
//  LoginAndRegistrationViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 21/03/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class LoginAndRegistrationViewController: UIViewController {

    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var forgetView: UIView!
    @IBOutlet weak var resetView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       
        loginView.isHidden = false
        signUpView.isHidden = true
        forgetView.isHidden = true
        resetView.isHidden = true
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(ForgetPasswordAction), name: Notification.Name("ForgetPassword"), object: nil)
        
        nc.addObserver(self, selector: #selector(resetPassword), name: Notification.Name("ResetPassword"), object: nil)
        
        nc.addObserver(self, selector: #selector(openLoginView), name: Notification.Name("openLoginView"), object: nil)
        

        
    }
    
    
    @objc func ForgetPasswordAction() {
        
        print("ForgetPasswordAction Called")
        
        loginView.isHidden = true
        signUpView.isHidden = true
        segmentControl.isHidden = true
        forgetView.isHidden = false
        resetView.isHidden = true
    }
    
    @objc func resetPassword() {
        
        loginView.isHidden = true
        signUpView.isHidden = true
        segmentControl.isHidden = true
        forgetView.isHidden = true
        resetView.isHidden = false
    }
    
    @objc func openLoginView() {
        
        loginView.isHidden = false
        signUpView.isHidden = true
        segmentControl.isHidden = false
        forgetView.isHidden = true
        resetView.isHidden = true
    }
    
    
    @IBAction func SegmentControlAction(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            loginView.isHidden = false
            signUpView.isHidden = true
        }
        else {
            loginView.isHidden = true
            signUpView.isHidden = false
        }
        
    }
    
    @IBAction func cancelPresentAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    

}

