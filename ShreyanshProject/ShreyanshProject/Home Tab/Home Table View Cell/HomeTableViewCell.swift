//
//  HomeTableViewCell.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 21/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var section: Int = -1
    var popularityArray = [Popularity]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        homeCollectionView.register(nib, forCellWithReuseIdentifier: "HomeCollectionCell")
        
        
        getPopularityData()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func getPopularityData() {
        
        let request = AF.request("https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=\(TMDBApiKey)")
                
        request.responseDecodable(of: PopularityResults.self) { (response) in
          
            guard let popularityData = response.value else { return }
                        
            DispatchQueue.main.async {

                self.popularityArray = popularityData.results
                
                for i in self.popularityArray {
                    print("Popularity : \(i.rating)")
                }

                self.homeCollectionView.reloadData()
            }
        }
        
    }
    
    
    
    
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularityArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.MovieNameLabel.text = popularityArray[indexPath.row].title
        cell.movieTypeLabel.text = "Action"
        cell.ratingLabel.text = String(popularityArray[indexPath.row].rating)
        
        AF.request("https://image.tmdb.org/t/p/w500\(popularityArray[indexPath.row].posterImage)").responseImage { response in
            
            if case .success(let image) = response.result {
                cell.HomeCollectionImageView.image = image
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 180, height: 200)
    }

    
    
}
