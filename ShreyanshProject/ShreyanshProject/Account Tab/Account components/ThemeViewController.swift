//
//  ThemeViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 01/06/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class ThemeViewController: UIViewController {

    @IBOutlet weak var changeBackgroundColorButton: UIButton!
    @IBOutlet weak var chnageFontButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if UserDefaults.standard.object(forKey: "backgroundColour") == nil {
            UserDefaults.standard.set("#00000", forKey: "backgroundColour")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = Theme.color(type: .backgroundColor)
    }
    
    
    @IBAction func changeBackgroundcolorAction(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "BackgroundColorViewController") as! BackgroundColorViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
