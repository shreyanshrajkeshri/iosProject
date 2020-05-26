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


protocol CellDelegate {
    func colCategorySelected(_ indexPath : IndexPath, _ movieClickDetails: [Movies])
}

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var customSection: Int = -1
    
    var popularityArray = [Movies]()
    var dramaArray = [Movies]()
    var thrillerArray = [Movies]()
    var comedyArray = [Movies]()
    
    var delegate : CellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        homeCollectionView.register(nib, forCellWithReuseIdentifier: "HomeCollectionCell")
        
        
        getPopularityDataFromAPI()
        getDramaDataFromAPI()
        getThrillerDataFromAPI()
        getComedyDataFromAPI()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    func getPopularityDataFromAPI() {
        
        print("getPopularityDataFromAPI")
        
        let request = AF.request("https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=\(TMDBApiKey)")
                
        request.responseDecodable(of: MoviesResults.self) { (response) in
          
            guard let popularityData = response.value else { return }
                        
            DispatchQueue.main.async {

                self.popularityArray = popularityData.results

                self.homeCollectionView.reloadData()
            }
        }
        
    }
    
    func getDramaDataFromAPI() {
        
        let request = AF.request("https://api.themoviedb.org/3/discover/movie?with_genres=18&primary_release_year=2020&api_key=\(TMDBApiKey)")
                
        request.responseDecodable(of: MoviesResults.self) { (response) in
          
            guard let dramaData = response.value else { return }
                        
            DispatchQueue.main.async {

                self.dramaArray = dramaData.results

                self.homeCollectionView.reloadData()
            }
        }
        
    }
    
    
    func getThrillerDataFromAPI() {
       
        let request = AF.request("https://api.themoviedb.org/3/discover/movie?with_genres=53&primary_release_year=2020&api_key=\(TMDBApiKey)")
     
                
        request.responseDecodable(of: MoviesResults.self) { (response) in
          
            guard let thrillerData = response.value else { return }
                        
            DispatchQueue.main.async {

                self.thrillerArray = thrillerData.results

                self.homeCollectionView.reloadData()
            }
        }
        
    }
    
    func getComedyDataFromAPI() {
        
        let request = AF.request("https://api.themoviedb.org/3/discover/movie?with_genres=35&primary_release_year=2020&api_key=\(TMDBApiKey)")
                
        request.responseDecodable(of: MoviesResults.self) { (response) in
          
            guard let comedyData = response.value else { return }
                        
            DispatchQueue.main.async {

                self.comedyArray = comedyData.results

                self.homeCollectionView.reloadData()
            }
        }
        
    }
    
    
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch customSection {
        case 1:
            return popularityArray.count
        case 2:
            return dramaArray.count
        case 3:
            return thrillerArray.count
        case 4:
            return comedyArray.count
        case 5:
            return popularityArray.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionViewCell
                
        switch customSection {
            
        case 1:
            
            cell.MovieNameLabel.text = popularityArray[indexPath.row].title
            cell.movieTypeLabel.text = "Action"
            cell.ratingLabel.text = String(popularityArray[indexPath.row].rating)
            
            AF.request("https://image.tmdb.org/t/p/w500\(popularityArray[indexPath.row].posterImage)").responseImage { response in
                
                if case .success(let image) = response.result {
                    cell.HomeCollectionImageView.image = image
                }
            }
            
        case 2:
            
            cell.MovieNameLabel.text = dramaArray[indexPath.row].title
            cell.movieTypeLabel.text = "Drama"
            cell.ratingLabel.text = String(dramaArray[indexPath.row].rating)
            
            AF.request("https://image.tmdb.org/t/p/w500\(dramaArray[indexPath.row].posterImage)").responseImage { response in
                
                if case .success(let image) = response.result {
                    cell.HomeCollectionImageView.image = image
                }
            }
            
        case 3:
            
            cell.MovieNameLabel.text = thrillerArray[indexPath.row].title
            cell.movieTypeLabel.text = "Thriller"
            cell.ratingLabel.text = String(thrillerArray[indexPath.row].rating)
            
            AF.request("https://image.tmdb.org/t/p/w500\(thrillerArray[indexPath.row].posterImage)").responseImage { response in
                
                if case .success(let image) = response.result {
                    cell.HomeCollectionImageView.image = image
                }
            }
            
        case 4:
            
            cell.MovieNameLabel.text = comedyArray[indexPath.row].title
            cell.movieTypeLabel.text = "Comedy"
            cell.ratingLabel.text = String(comedyArray[indexPath.row].rating)
            
            AF.request("https://image.tmdb.org/t/p/w500\(comedyArray[indexPath.row].posterImage)").responseImage { response in
                
                if case .success(let image) = response.result {
                    cell.HomeCollectionImageView.image = image
                }
            }
            
        case 5:
            
            cell.MovieNameLabel.text = popularityArray[indexPath.row].title
            cell.movieTypeLabel.text = "Action"
            cell.ratingLabel.text = String(popularityArray[indexPath.row].rating)
            
            AF.request("https://image.tmdb.org/t/p/w500\(popularityArray[indexPath.row].posterImage)").responseImage { response in
                
                if case .success(let image) = response.result {
                    cell.HomeCollectionImageView.image = image
                }
            }
            
        default:
            print("cell Default")
        }
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 180, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        homeCollectionView.deselectItem(at: indexPath, animated: true)
        
        print("CellDelegate")
        
        switch customSection {
        case 1:
            delegate?.colCategorySelected(indexPath, popularityArray)
        case 2:
            delegate?.colCategorySelected(indexPath, dramaArray)
        case 3:
            delegate?.colCategorySelected(indexPath, thrillerArray)
        case 4:
            delegate?.colCategorySelected(indexPath, comedyArray)
        case 5:
            delegate?.colCategorySelected(indexPath, popularityArray)
        default:
            print("Defalut")
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in homeCollectionView.visibleCells {
            let indexPath = homeCollectionView.indexPath(for: cell)
            print(indexPath as Any)
        }
    }
    
    
}
