//
//  MovieDetailsCollectionViewCell.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 23/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class MovieDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieDetailsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        movieDetailsImageView.layer.cornerRadius = 10
        movieDetailsImageView.clipsToBounds = true
        
    }

}
