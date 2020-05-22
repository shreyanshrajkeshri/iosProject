//
//  LanguageTableViewCell.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 22/03/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {

    @IBOutlet weak var laguageIconImageView: UIImageView!
    @IBOutlet weak var languageTitleLabel: UILabel!
    @IBOutlet weak var languageNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLaguageIconImageView(image: UIImage) {
        laguageIconImageView.image = image
    }
    
    func setLanguageTitleLabel(text: String) {
        languageTitleLabel.text = text
    }
    
    func setLanguageNameLabel(text: String) {
        languageNameLabel.text = text
    }
}
