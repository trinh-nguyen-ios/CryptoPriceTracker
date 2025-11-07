//
//  PriceListTableViewCell.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 7/11/25.
//

import UIKit

class PriceListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(name: String, price: String) {
        self.nameLabel.text = name
        self.priceLabel.text = "$" + price
    }
}
