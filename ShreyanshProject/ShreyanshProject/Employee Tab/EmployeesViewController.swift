//
//  EmployeesViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 20/03/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class EmployeesViewController: UIViewController {
    
    @IBOutlet weak var listedView: UIView!
    @IBOutlet weak var detailsView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        listedView.isHidden = false
        detailsView.isHidden = true
         
    }
    

    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            listedView.isHidden = false
            detailsView.isHidden = true
        }
        else {
            listedView.isHidden = true
            detailsView.isHidden = false
        }
    }
    
}
