//
//  CountryListTableViewCell.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 24/03/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFlageImageView(image: UIImage) {
        
        flagImageView.image = image
    }
    
    func setCountryNameLabel(text: String) {
        
        countryNameLabel.text = text
    }
    
}
