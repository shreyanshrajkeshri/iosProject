//
//  ImagesSliderTableViewCell.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 21/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class ImagesSliderTableViewCell: UITableViewCell {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageViewController: UIPageControl!
    
    
    var trendingArray = [Trending]()

    var timer = Timer()
    var counter = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        
        let nib = UINib(nibName: "SliderCollectionViewCell", bundle: nil)
               sliderCollectionView.register(nib, forCellWithReuseIdentifier: "SliderCollectionCell")
        
        
        getTrandingData()
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func changeImage() {
        
        if counter<trendingArray.count {
         
            let index = IndexPath(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageViewController.currentPage = counter
            counter += 1
        }
        else {
            
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageViewController.currentPage = counter
            counter = 1
        }
        
    }

    
    func getTrandingData() {
        
        let request = AF.request("https://api.themoviedb.org/3/trending/all/day?api_key=\(TMDBApiKey)")
        
        request.responseDecodable(of: TrendingResults.self) { (response) in
          
            guard let trendingData = response.value else { return }
            
            DispatchQueue.main.async {

                self.trendingArray = trendingData.results

                self.sliderCollectionView.reloadData()
            }
        }
        
    }
    
}


extension ImagesSliderTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = sliderCollectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionCell", for: indexPath) as! SliderCollectionViewCell
              
              
          AF.request("https://image.tmdb.org/t/p/w500\(trendingArray[indexPath.row].posterImage)").responseImage { response in
                  
                  if case .success(let image) = response.result {
                      cell.sliderImageView.image = image
                  }
              }
        
              return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: sliderCollectionView.frame.height)
    }

    
}

