//
//  BackgroundColorViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 01/06/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class BackgroundColorViewController: UIViewController {
    
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        button1.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "D4E8BE")
        button2.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "C0E0ED")
        button3.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "C5FF66")
        button4.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "F7B592")
        button5.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "ABB7F7")
        button6.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "D080FF")
        button7.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "FFB1FA")
        button8.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "B77FA3")
        button9.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "000000")
        
        view.backgroundColor = UIColor.gray
    }
    
    @IBAction func backgroundColorButtonAction(_ sender: UIButton) {
        
        if sender.tag == 0 {
            UserDefaults.standard.set("#D4E8BE", forKey: "backgroundColour")
        }
        else if sender.tag == 1 {
            UserDefaults.standard.set("#C0E0ED", forKey: "backgroundColour")
        }
        else if sender.tag == 2 {
            UserDefaults.standard.set("#C5FF66", forKey: "backgroundColour")
        }
        else if sender.tag == 3 {
            UserDefaults.standard.set("#F7B592", forKey: "backgroundColour")
        }
        else if sender.tag == 4 {
            UserDefaults.standard.set("#ABB7F7", forKey: "backgroundColour")
        }
        else if sender.tag == 5 {
            UserDefaults.standard.set("#D080FF", forKey: "backgroundColour")
        }
        else if sender.tag == 6 {
            UserDefaults.standard.set("#FFB1FA", forKey: "backgroundColour")
        }
        else if sender.tag == 7 {
            UserDefaults.standard.set("#B77FA3", forKey: "backgroundColour")
        }
        else if sender.tag == 8 {
            UserDefaults.standard.set("#000000", forKey: "backgroundColour")
            
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
}
