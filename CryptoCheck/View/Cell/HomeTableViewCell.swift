//
//  HomeTableViewCell.swift
//  CryptoCheck
//
//  Created by Karim Arhan on 14/01/25.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public var item: Crypto! {
        didSet {
            self.currencyLabel.text = item.currency
            self.priceLabel.text = item.price
        }
    }
    
}
