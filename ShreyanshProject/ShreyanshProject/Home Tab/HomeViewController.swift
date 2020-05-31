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
    
    
    var movieTypeName = [nil, "Popular", "Drama", "Thriller", "Comedy", "Horror"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        setupNIb()
        
        setButtonOnNavigationBar()
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateDataInVisibleCell()
    }
    
    
    // Here hit the API for the which cell is visiable
    func updateDataInVisibleCell() {
        
        for cell in homeTableView.visibleCells {
            let indexPath = homeTableView.indexPath(for: cell)
            print("Table View : ====> \(indexPath!)")
            let indexSet = indexPath!
            
            let cell = homeTableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath!) as! HomeTableViewCell
            
            cell.getData(customIndex: indexPath!.section)
            
            self.homeTableView.reloadSections([indexSet.section, indexSet.row], with: .fade)
        }
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
        
        self.homeTableView.reloadSections([1,0], with: .automatic)
    }


}


//MARK: TableView Extension
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
            
            cell.customSection = indexPath.section
            cell.delegate = self as CellDelegate
            
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieTypeName.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return movieTypeName[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 300
        }
        
        return 220
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        print(movieTypeName[indexPath.section] ?? "MovieTypeName")
        
    }
    
    
    //this is called when we scroll the table view
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        updateDataInVisibleCell()

    }
    
    
    
}


//MARK:- CellDelegate

//this help to present showDetailsViewController when we click the movie inside section of tableview

extension HomeViewController: CellDelegate {
    
    func colCategorySelected(_ indexPath: IndexPath, _ movieClickDetails: [Movies]) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowDetailsViewController") as! ShowDetailsViewController
        
        vc.modalPresentationStyle = .fullScreen
        vc.movieDetails = movieClickDetails
        vc.customIndex = indexPath.row
        
        AF.request("https://image.tmdb.org/t/p/w500\(movieClickDetails[indexPath.row].movieImage)").responseImage { response in
            
            if case .success(let image) = response.result {
                vc.movieImageView.image = image
            }
        }
        
        print("INdex ====> \(indexPath)")
        
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
   
    
}
