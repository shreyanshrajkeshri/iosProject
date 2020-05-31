//
//  MovieDetailsCollectionViewCell.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 23/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class MovieDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieDetailsContentView: UIView!
    @IBOutlet weak var movieDetailsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        movieDetailsImageView.layer.cornerRadius = 10
        movieDetailsImageView.clipsToBounds = true
        
        movieDetailsContentView.backgroundColor = UIColor.clear
        movieDetailsContentView.layer.shadowColor = UIColor.darkGray.cgColor
        movieDetailsContentView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        movieDetailsContentView.layer.shadowOpacity = 0.6
        movieDetailsContentView.layer.shadowRadius = 5.0
        
    }

}
