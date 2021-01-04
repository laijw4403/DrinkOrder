//
//  DrinkOrderTableViewCell.swift
//  DrinkOrder
//
//  Created by Tommy on 2020/12/28.
//

import UIKit

class DrinkOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var selectionLabel: UILabel!
    @IBOutlet weak var addPriceLabel: UILabel!
    @IBOutlet weak var addFeedPriceLabel: UILabel!
    @IBOutlet weak var radioButtonImage: UIImageView!
    @IBOutlet weak var radioButton: UIButton! {
        didSet {
            radioButton.setImage(UIImage(named: "radio_off"), for: .normal)
            radioButton.setImage(UIImage(named: "radio_on"), for: .selected)
        }
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    
}


