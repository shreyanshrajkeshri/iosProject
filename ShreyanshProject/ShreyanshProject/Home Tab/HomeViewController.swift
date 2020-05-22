//
//  HomeViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 20/03/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
        
    var trandingArray = [Trending]()
    
    var moviename = [nil, "Action", "Drama", "Science Fiction", "Kids", "Horror"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        setupNIb()
        
        setButtonOnNavigationBar()
 
    }
    
    func setupNIb() {
        
        let nib1 = UINib(nibName: "HomeTableViewCell", bundle: nil)
        homeTableView.register(nib1, forCellReuseIdentifier: "HomeTableCell")
        
        let nib2 = UINib(nibName: "ImagesSliderTableViewCell", bundle: nil)
        homeTableView.register(nib2, forCellReuseIdentifier: "ImagesSliderTableCell")
    }
    
    func setButtonOnNavigationBar() {
        
        let searchBar = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonAction(sender:)))
        
            navigationItem.rightBarButtonItems = [searchBar]
    }
    
    
    @objc func notificationButtonAction(sender: AnyObject){
        print("Notification")
    }

    @objc func searchButtonAction(sender: AnyObject){
        print("Search")
    }


}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0) {
            
            let cell2 = homeTableView.dequeueReusableCell(withIdentifier: "ImagesSliderTableCell", for: indexPath) as! ImagesSliderTableViewCell
            
            return cell2
        }
        
        else {
            let cell = homeTableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableViewCell
        
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return moviename.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return moviename[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 300
        }
        
        return 220
    }
    
}

