//
//  CountryTableViewCell.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 22/03/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryIconImageView: UIImageView!
    @IBOutlet weak var countryTitleLabel: UILabel!
    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    
    func setCountryIconImageView(image: UIImage) {
        countryIconImageView.image = image
    }
    
    func setCountryTitleLabel(text: String) {
        countryTitleLabel.text = text
    }
    
    func setCountryFlagImageView(image: UIImage) {
        countryFlagImageView.image = image
    }
    
    func setCountryNameLabel(text: String) {
        countryNameLabel.text = text
    }
}
