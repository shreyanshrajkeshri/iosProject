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
    
    
    struct Country {
        let countryName: String
        let countryCode: String
    }
    
    // Details use For LaguageTableCell
    var languageNameArray = [String]()
    
    //details Use For CountryTabelCell
    let flagImageDemo = #imageLiteral(resourceName: "IndiaFlag")

    // Use NSLocale and get CountryCode after that use compactMap and change to full name string
    // we use CompactMap due to its only take non-empty value.
    var countryArray = [Country]()
    var countryCodeArray = NSLocale.isoCountryCodes
    var countryNameArray = NSLocale.isoCountryCodes.compactMap {
        NSLocale.current.localizedString(forRegionCode: $0) }


    //this is help to find which mode is selected for example "Country" for use CountryTableCell and "Language" for use LanguageTableCell
    
    //TODO: try to use this by using enum
    public static var cellMode: String = "None"
    
    let searchController = UISearchController(searchResultsController: nil)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "LanguageListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LanguageListTableCell")
        
        let nib2 = UINib(nibName: "CountryListTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "CountryListTableCell")
        
        
        //To remove extra cell from tabelview
        tableView.tableFooterView = UIView()
        
        //create search Bar
        searchBarSetup()
        
        fillValueOfLanguageNameArray()
        fillValueOfcountryNameArray()
        
        
    }
    
    
    func searchBarSetup() {
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
        //by default the background is hide/blur when search bar is activate so we give them false to make background unhide
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func fillValueOfLanguageNameArray() {
        
        // Use Locale and get language Code after that use compactMap and change to full name string
        // we use CompactMap due to its only take non-empty value.
        // we sorted them is accending orderby using .sorted()
        
        languageNameArray = Locale.isoLanguageCodes.compactMap {
        Locale.current.localizedString(forLanguageCode: $0) }.sorted()
    }
    
    func fillValueOfcountryNameArray() {
        
        //remove all value form array then append new data
        countryArray.removeAll()
        
        for i in 0..<countryNameArray.count {
            
            countryArray.append( Country(countryName: countryNameArray[i], countryCode: countryCodeArray[i]) )
        }
    }
    
}

extension CountryAndLanguageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //check which mode is use and return that much of integer value accounding to this.
        
        switch CountryAndLanguageViewController.cellMode {
        case "Country":
            return countryArray.count
        case "Language":
            return languageNameArray.count
        default:
            return 0
        }
        
    }
    
   
    //MARK: Cell For Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //for Mode is "Country"
        if CountryAndLanguageViewController.cellMode == "Country" {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableCell", for: indexPath) as! CountryListTableViewCell
            
            cell.setCountryNameLabel(text: countryArray[indexPath.row].countryName)
            
            //this is code to get image from server via countryCode and set it in cell.FlagImage
            if let url = URL(string: "https://www.countryflags.io/\(countryArray[indexPath.row].countryCode)/flat/64.png") {
                
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            
                            //here i pass image to cell.FlagImage
                            cell.setFlageImageView(image: UIImage(data: data) ?? self.flagImageDemo)
                            cell.flagImageView.contentMode = .scaleAspectFill
                        }
                    }
                }.resume()
            }
            
            return cell
        }
        
            
        //for Mode is "Language"
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageListTableCell", for: indexPath) as! LanguageListTableViewCell
            
            cell.setLanguageListLabel(text: languageNameArray[indexPath.row])
            
            return cell
        }
    }
    
    
    //MARK: Did Select Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if CountryAndLanguageViewController.cellMode == "Country" {
            
            AccountViewController.countryCode = countryArray[indexPath.row].countryCode
        }
            
        else {
           
            //pass the selected language name and prefix them (3) also change all letter in uppercase
            
            AccountViewController.languageName = String(languageNameArray[indexPath.row].prefix(3).uppercased())
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
}


//MARK: SearchBar Extension
extension CountryAndLanguageViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    //function of UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else { return }
        
        if CountryAndLanguageViewController.cellMode == "Language" {
            
            fillValueOfLanguageNameArray()
            
            //Run is Code when searchText is non-empty
            if !searchText.isEmpty {
                
                languageNameArray = languageNameArray.filter{
                    $0.contains(searchText) }
            }
        }
        // cellmode is "Country"
        else{
            
            fillValueOfcountryNameArray()
            
            //Run is Code when searchText is non-empty
            if !searchText.isEmpty {
        
                countryArray = countryArray.filter {
                    $0.countryName.contains(searchText) }
            }
        }
        
        //reload the tableview every type
        tableView.reloadData()
    }
    
  
}
