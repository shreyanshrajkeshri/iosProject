//
//  FavouriteTableViewCell.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 30/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var favouriteMovieNameLabel: UILabel!
    @IBOutlet weak var favouriteRatingLabel: UILabel!
    @IBOutlet weak var favouriteDescriptionLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outerView.layer.cornerRadius = 5
        outerView.clipsToBounds = true
        
        cellContentView.backgroundColor = UIColor.clear
        cellContentView.layer.shadowColor = UIColor.darkGray.cgColor
        cellContentView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cellContentView.layer.shadowOpacity = 0.6
        cellContentView.layer.shadowRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
