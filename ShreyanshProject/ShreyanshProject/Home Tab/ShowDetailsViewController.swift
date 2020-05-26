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
    
    var movieDetails = [Movies]()
    var popularityArray = [Movies]()
    
    var customIndex: Int = -1

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        movieDetailsCollectionView.delegate = self
        movieDetailsCollectionView.dataSource = self
       
        fillTheSelectedMovieInfo()
        
        let nib = UINib(nibName: "MovieDetailsCollectionViewCell", bundle: nil)
        movieDetailsCollectionView.register(nib, forCellWithReuseIdentifier: "MovieDetailsCollectionCell")
        
        
    }
    
    @IBAction func PopAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func fillTheSelectedMovieInfo() {
        
        movieTitleLabel.text = movieDetails[customIndex].title
        movieRatingLabel.text = "\(movieDetails[customIndex].rating)/10"
        movieDescriptionLabel.text = movieDetails[customIndex].description
        movieTypeLabel.text = "ACTION  |  ENGLISH  |  \(movieDetails[customIndex].releaseDate)"
        
        
        movieDetails.remove(at: customIndex)
      
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
