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

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageViewControl: UIPageControl!
    
        
    var trandingArray = [Tranding]()
    
    var timer = Timer()
    var counter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        
        let nib = UINib(nibName: "SliderCollectionViewCell", bundle: nil)
        sliderCollectionView.register(nib, forCellWithReuseIdentifier: "SliderCollectionCell")
        
        
//        pageViewControl.numberOfPages = trandingArray.count
//        pageViewControl.currentPage = 0
//
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        getTrandingData()
       
        let searchBar = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonAction(sender:)))
    
        navigationItem.rightBarButtonItems = [searchBar]
 
    }
    
    
    @objc func changeImage() {
        
        if counter<trandingArray.count {
         
            let index = IndexPath(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageViewControl.currentPage = counter
            counter += 1
        }
        else {
            
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageViewControl.currentPage = counter
            counter = 1
        }
        
    }
    
    func getTrandingData() {
        
        let request = AF.request("https://api.themoviedb.org/3/trending/all/day?api_key=\(TMDBApiKey)")
        
        request.responseDecodable(of: TrandingResults.self) { (response) in
          
            guard let trandingData = response.value else { return }
            
            DispatchQueue.main.async {

                self.trandingArray = trandingData.results

                for i in self.trandingArray {
                    print("Poster : \(i.posterImage)")
                }

                self.sliderCollectionView.reloadData()
            }
        }
        
    }
    
    @objc func notificationButtonAction(sender: AnyObject){
        print("Notification")
    }

    @objc func searchButtonAction(sender: AnyObject){
        print("Search")
    }


}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trandingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = sliderCollectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionCell", for: indexPath) as! SliderCollectionViewCell
        
        
    AF.request("https://image.tmdb.org/t/p/w500\(trandingArray[indexPath.row].posterImage)").responseImage { response in
            
            if case .success(let image) = response.result {
                cell.sliderImageView.image = image
            }
        }
  
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
           return CGSize(width: view.frame.width, height: 250)
       }
       
   
}


