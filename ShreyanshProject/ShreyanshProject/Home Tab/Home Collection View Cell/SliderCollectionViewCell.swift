//
//  SliderCollectionViewCell.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 20/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sliderContectView: UIView!
    @IBOutlet weak var sliderImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sliderImageView.layer.cornerRadius = 10
        sliderImageView.clipsToBounds = true
        
        sliderContectView.backgroundColor = UIColor.clear
        sliderContectView.layer.shadowColor = UIColor.darkGray.cgColor
        sliderContectView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        sliderContectView.layer.shadowOpacity = 0.6
        sliderContectView.layer.shadowRadius = 5.0
        
    }

}
