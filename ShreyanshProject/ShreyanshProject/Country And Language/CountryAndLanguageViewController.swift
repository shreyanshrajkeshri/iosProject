//
//  CountryAndLanguageViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 24/03/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class CountryAndLanguageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let languageArray = ["CHINESE", "SPANISH", "ENGLISH", "HINDI", "ARABIC", "PORTUGUESE", "BENGALI", "RUSSIAN", "JAPANESE", "FRENCH"]
    
    let countryNameArray = ["BTN", "IND", "FRA", "ISL", "NPL", "LKA", "USA", "VNM"]
    let flagArray = [ #imageLiteral(resourceName: "ButanFlag"), #imageLiteral(resourceName: "IndiaFlag"), #imageLiteral(resourceName: "FranceFlag"), #imageLiteral(resourceName: "IcelandFlag"), #imageLiteral(resourceName: "NepalFlag"), #imageLiteral(resourceName: "SriLankaFlag"), #imageLiteral(resourceName: "UnitedStatesOfAmericaFlag"), #imageLiteral(resourceName: "VietnamFlag")]
    
    
    public static var cellMode: String = "None"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "LanguageListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LanguageListTableCell")
        
        let nib2 = UINib(nibName: "CountryListTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "CountryListTableCell")
        
    }
    

}

extension CountryAndLanguageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch CountryAndLanguageViewController.cellMode {
        case "Country":
            return countryNameArray.count
        case "Language":
            return languageArray.count
        default:
            return 0
        }
    }
    
    //MARK: Cell For Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if CountryAndLanguageViewController.cellMode == "Country" {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableCell", for: indexPath) as! CountryListTableViewCell
            
            cell.setCountryNameLabel(text: countryNameArray[indexPath.row] )
            cell.setFlageImageView(image: flagArray[indexPath.row] )
            
            
            return cell
        }
        
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageListTableCell", for: indexPath) as! LanguageListTableViewCell
            
            cell.setLanguageListLabel(text: languageArray[indexPath.row])
            
            return cell
        }
    }
    
    
    //MARK: Did Select Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if CountryAndLanguageViewController.cellMode == "Country" {
            
            AccountViewController.countryName = countryNameArray[indexPath.row]
            AccountViewController.flagImage = flagArray[indexPath.row]
        }
            
        else {
           
            AccountViewController.languageName = String(languageArray[indexPath.row].prefix(3))
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
}
