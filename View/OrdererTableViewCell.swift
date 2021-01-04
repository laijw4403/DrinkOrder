//
//  OrdererTableViewCell.swift
//  DrinkOrder
//
//  Created by Tommy on 2020/12/30.
//

import UIKit

class OrdererTableViewCell: UITableViewCell {

    @IBOutlet weak var ordererLabel: UILabel!
    @IBOutlet weak var ordererNameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
