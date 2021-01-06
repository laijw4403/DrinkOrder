//
//  OrderListTableViewCell.swift
//  DrinkOrder
//
//  Created by Tommy on 2021/1/5.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {

    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var ordererNameLabel: UILabel!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkSizeLabel: UILabel!
    @IBOutlet weak var drinkSugarLabel: UILabel!
    @IBOutlet weak var drinkTempLabel: UILabel!
    @IBOutlet weak var drinkAddFeedLabel: UILabel!
    @IBOutlet weak var drinkPriceLabel: UILabel!
    @IBOutlet weak var drinkQuantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
