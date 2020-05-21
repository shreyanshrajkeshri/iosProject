//
//  HomeImageSliderCollectionViewCell.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 21/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class HomeImageSliderCollectionViewCell: UITableViewCell {

    @IBOutlet weak var homeImageSliderCollectionView: UICollectionView!
    @IBOutlet weak var homePageViewControl: UIPageControl!
    
    
    var trandingArray = [Trending]()
    
    var timer = Timer()
    var counter = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        homeImageSliderCollectionView.delegate = self
        homeImageSliderCollectionView.dataSource = self
        
        let nib = UINib(nibName: "SliderCollectionViewCell", bundle: nil)
        homeImageSliderCollectionView.register(nib, forCellWithReuseIdentifier: "SliderCollectionCell")
        
        getTrandingData()
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
        
        if counter<trandingArray.count {
         
            let index = IndexPath(item: counter, section: 0)
            self.homeImageSliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            homePageViewControl.currentPage = counter
            counter += 1
        }
        else {
            
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            self.homeImageSliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            homePageViewControl.currentPage = counter
            counter = 1
        }
        
    }
    
    
    func getTrandingData() {
        
        let request = AF.request("https://api.themoviedb.org/3/trending/all/day?api_key=\(TMDBApiKey)")
        
        request.responseDecodable(of: TrendingResults.self) { (response) in
          
            guard let trandingData = response.value else { return }
            
            DispatchQueue.main.async {

                self.trandingArray = trandingData.results

                for i in self.trandingArray {
                    print("Poster : \(i.posterImage)")
                }

                self.homeImageSliderCollectionView.reloadData()
            }
        }
        
    }

}

extension HomeImageSliderCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trandingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = homeImageSliderCollectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionCell", for: indexPath) as! SliderCollectionViewCell
              
              
          AF.request("https://image.tmdb.org/t/p/w500\(trandingArray[indexPath.row].posterImage)").responseImage { response in
                  
                  if case .success(let image) = response.result {
                      cell.sliderImageView.image = image
                  }
              }
        
              return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 415, height: 320)
    }

    
}
