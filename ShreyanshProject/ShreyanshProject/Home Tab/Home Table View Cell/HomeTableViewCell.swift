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
    var flagArray = [false, false, false, false, false]
    
    var moviesDetails = [[Movies]]()
    
    var delegate : CellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        homeCollectionView.register(nib, forCellWithReuseIdentifier: "HomeCollectionCell")
        
        
        
        moviesDetails = [[Movies](), [Movies](), [Movies](), [Movies](), [Movies]()]
        
        getData(customIndex: 1)
        getData(customIndex: 2)
        getData(customIndex: 3)
        getData(customIndex: 4)
        getData(customIndex: 5)
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func getData(customIndex: Int) {
    
        
        switch customIndex {
            
        case 1:
            getShowsFrom(url: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=\(TMDBApiKey)", index: 0)
        case 2:
            getShowsFrom(url: "https://api.themoviedb.org/3/discover/movie?primary_release_date.gte=2019-09-15&primary_release_date.lte=2019-10-22&api_key=\(TMDBApiKey)", index: 1)
        case 3:
            getShowsFrom(url: "https://api.themoviedb.org/3/discover/movie?with_genres=53&api_key=\(TMDBApiKey)", index: 2)
        case 4:
            getShowsFrom(url: "https://api.themoviedb.org/3/discover/movie?certification_country=US&certification.lte=G&sort_by=popularity.desc&api_key=\(TMDBApiKey)", index: 3)
        case 5:
            getShowsFrom(url: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=\(TMDBApiKey)", index: 4)
        default:
            print("Default")
        }
        
    }
    
    
    func getShowsFrom(url: String, index: Int) {
        
        print("Section :===========> \(index)")
        
        let request = AF.request(url)
        
        request.responseDecodable(of: MoviesResults.self) { (response) in
            
            guard let showData = response.value else { return }
            
            self.moviesDetails[index] = showData.results
            
            self.homeCollectionView.reloadData()
        }
        
    }
    
}

    
    


extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch customSection {
        case 1:
            return moviesDetails[0].count
        case 2:
            return moviesDetails[1].count
        case 3:
            return moviesDetails[2].count
        case 4:
            return moviesDetails[3].count
        case 5:
            return moviesDetails[4].count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionViewCell
                
        switch customSection {
            
        case 1:
            
            print( moviesDetails[0][indexPath.row].title)
            
            cell.MovieNameLabel.text = moviesDetails[0][indexPath.row].title
            cell.movieTypeLabel.text = "Action"
            cell.ratingLabel.text = String(moviesDetails[0][indexPath.row].rating)
            
            AF.request("https://image.tmdb.org/t/p/w500\(moviesDetails[0][indexPath.row].posterImage)").responseImage { response in
                
                if case .success(let image) = response.result {
                    cell.HomeCollectionImageView.image = image
                }
            }
            
        case 2:
            
            cell.MovieNameLabel.text = moviesDetails[1][indexPath.row].title
            cell.movieTypeLabel.text = "Drama"
            cell.ratingLabel.text = String(moviesDetails[1][indexPath.row].rating)
            
            AF.request("https://image.tmdb.org/t/p/w500\(moviesDetails[1][indexPath.row].posterImage)").responseImage { response in
                
                if case .success(let image) = response.result {
                    cell.HomeCollectionImageView.image = image
                }
            }
            
        case 3:
            
            cell.MovieNameLabel.text =  moviesDetails[2][indexPath.row].title
            cell.movieTypeLabel.text = "Thriller"
            cell.ratingLabel.text = String( moviesDetails[2][indexPath.row].rating)
            
            AF.request("https://image.tmdb.org/t/p/w500\( moviesDetails[2][indexPath.row].posterImage)").responseImage { response in
                
                if case .success(let image) = response.result {
                    cell.HomeCollectionImageView.image = image
                }
            }
            
        case 4:
            
            cell.MovieNameLabel.text =  moviesDetails[3][indexPath.row].title
            cell.movieTypeLabel.text = "Comedy"
            cell.ratingLabel.text = String(moviesDetails[3][indexPath.row].rating)
            
            AF.request("https://image.tmdb.org/t/p/w500\(moviesDetails[3][indexPath.row].posterImage)").responseImage { response in
                
                if case .success(let image) = response.result {
                    cell.HomeCollectionImageView.image = image
                }
            }
            
        case 5:
            
            print(moviesDetails[4][indexPath.row].title)
            
            cell.MovieNameLabel.text = moviesDetails[4][indexPath.row].title
            cell.movieTypeLabel.text = "Action"
            cell.ratingLabel.text = String(moviesDetails[4][indexPath.row].rating)
            
            AF.request("https://image.tmdb.org/t/p/w500\(moviesDetails[4][indexPath.row].posterImage)").responseImage { response in
                
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
            delegate?.colCategorySelected(indexPath, moviesDetails[0])
        case 2:
            delegate?.colCategorySelected(indexPath, moviesDetails[1])
        case 3:
            delegate?.colCategorySelected(indexPath, moviesDetails[2])
        case 4:
            delegate?.colCategorySelected(indexPath, moviesDetails[3])
        case 5:
            delegate?.colCategorySelected(indexPath, moviesDetails[4])
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
