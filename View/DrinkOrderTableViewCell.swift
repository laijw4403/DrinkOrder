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
    
    @IBAction func selectedRadioButton(_ sender: UIButton) {
        radioButton.isSelected = !radioButton.isSelected
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
extension UIButton {
    //MARK:- Animate check mark
    func checkboxAnimation(closure: @escaping () -> Void){
        guard let image = self.imageView else {return}
        self.adjustsImageWhenHighlighted = false
        self.isHighlighted = false
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.isSelected = !self.isSelected
                //to-do
                closure()
                image.transform = .identity
            }, completion: nil)
        }
        
    }
}

