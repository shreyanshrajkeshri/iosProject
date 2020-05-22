//
//  LanguageListTableViewCell.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 24/03/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class LanguageListTableViewCell: UITableViewCell {

    @IBOutlet weak var languageListLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLanguageListLabel(text: String) {
        languageListLabel.text = text
    }
    
}
