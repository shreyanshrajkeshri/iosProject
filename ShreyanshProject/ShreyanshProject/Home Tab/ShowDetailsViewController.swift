//
//  ShowDetailsViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 22/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class ShowDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieDetailsCollectionView: UICollectionView!
    @IBOutlet weak var favouriteAddButton: UIButton!
    
    
    
    var movieDetails = [Movies]()
    static var selectedMovie = Movies()
    
    var customIndex: Int = -1
    var isFavourite = false
    var favouriteList = [Movies]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        movieDetailsCollectionView.delegate = self
        movieDetailsCollectionView.dataSource = self
        
        fillTheSelectedMovieInfo()
        
        let nib = UINib(nibName: "MovieDetailsCollectionViewCell", bundle: nil)
        movieDetailsCollectionView.register(nib, forCellWithReuseIdentifier: "MovieDetailsCollectionCell")
        
        
        fetchingFavourites()
        addGradientToImageView()
        
    }
    
    
    @IBAction func PopAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func addGradientToImageView(){
        
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = movieImageView.bounds
        
        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientMaskLayer.locations = [0, 0, 0.9, 1]
        
        movieImageView.layer.mask = gradientMaskLayer
    }
    
    
    func removeElement(element: Movies, from Array: inout [Movies]) -> Int {
        
        for i in 0..<Array.count {
            if Array[i].id == element.id {
                Array.remove(at: i)
                return i
            }
        }
        
        return -1
    }
    
    //MARK:- Function to check if selected item in in array or not
    func contain(obj: Movies, in array: [Movies]) -> Bool {
        
        for i in 0..<array.count {
            if obj.id == array[i].id {
                return true
            }
        }
        return false
    }
    
    
    //MARK:- Getting Favourite list from userDefaults
    func fetchingFavourites() {
        
        if UserDefaults.standard.object(forKey: "favList") != nil {
            // fetching
            
            if let fetchedArray = Array.fetch(using: "favList") {
                favouriteList = fetchedArray
                
                let doesContain = contain(obj: ShowDetailsViewController.selectedMovie, in: favouriteList)
                if doesContain == true {
                    
                    favouriteAddButton.setImage(#imageLiteral(resourceName: "heartFill"), for: .normal)
                    isFavourite = true
                }
                else {
                    
                    favouriteAddButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
                    isFavourite = false
                }
            }
            
        }
    }
    
    
    @IBAction func favouriteAddAction(_ sender: UIButton) {
        
        
        if isFavourite {
            sender.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
            removeElement(element: ShowDetailsViewController.selectedMovie, from: &favouriteList)
            isFavourite = false
        }
            
        else {
            sender.setImage(#imageLiteral(resourceName: "heartFill"), for: .normal)
            
            favouriteList.append(ShowDetailsViewController.selectedMovie)
            isFavourite = true
        }
        
        favouriteList.persist(using: "favList")
        
        
    }
    
    
    func fillTheSelectedMovieInfo() {
        
        ShowDetailsViewController.selectedMovie = movieDetails[customIndex]
        movieDetails.remove(at: customIndex)
        
        movieTitleLabel.text = ShowDetailsViewController.selectedMovie.title
        movieRatingLabel.text = "\(ShowDetailsViewController.selectedMovie.rating)/10"
        movieDescriptionLabel.text = ShowDetailsViewController.selectedMovie.description
        movieTypeLabel.text = "ACTION  |  ENGLISH  |  \(ShowDetailsViewController.selectedMovie.releaseDate)"
        
    }
    
}

extension ShowDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = movieDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailsCollectionCell", for: indexPath) as! MovieDetailsCollectionViewCell
        
        
        AF.request("https://image.tmdb.org/t/p/w500\(self.movieDetails[indexPath.row].posterImage)").responseImage { response in
            
            if case .success(let image) = response.result {
                cell.movieDetailsImageView.image = image
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: 100)
    }
    
    
    
    
}
