//
//  FavouriteViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 20/03/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit
import Alamofire

class FavouriteViewController: UIViewController {

    @IBOutlet weak var favouriteTableView: UITableView!
    
    var favMovies = [Movies]()
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self
        
        let nib = UINib(nibName: "FavouriteTableViewCell", bundle: nil)
        favouriteTableView.register(nib, forCellReuseIdentifier: "FavouriteTableCell")
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        if UserDefaults.standard.object(forKey: "favList") != nil {
            // fetching Movie data
            if let fetchedArray = Array.fetch(using: "favList") {
                favMovies = fetchedArray
            }
        }
        
        favouriteTableView.reloadData()
    }
  

}

extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favouriteTableView.dequeueReusableCell(withIdentifier: "FavouriteTableCell", for: indexPath) as! FavouriteTableViewCell
        
        cell.favouriteMovieNameLabel.text = favMovies[indexPath.row].title
        cell.favouriteRatingLabel.text = "\(favMovies[indexPath.row].rating)/10"
        cell.favouriteDescriptionLabel.text = favMovies[indexPath.row].description
        
        AF.request("https://image.tmdb.org/t/p/w500\(self.favMovies[indexPath.row].posterImage)").responseImage { response in
        
            if case .success(let image) = response.result {
                cell.favouriteImageView.image = image
                }
            }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        favouriteTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
