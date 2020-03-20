//
//  AccountTableViewCell.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 20/03/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak var accountCellLabel: UILabel!
    @IBOutlet weak var accountCellImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //function of set text to cell label
    func setValueToLabel(text: String) {
        
        accountCellLabel.text = text
    }
    
    //function of set image to cell image
    func setImage(image: UIImage) {
        
        accountCellImageView.image = image
    }
    
}
