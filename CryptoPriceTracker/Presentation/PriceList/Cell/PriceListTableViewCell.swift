//
//  PriceListTableViewCell.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 7/11/25.
//

import UIKit

final class PriceListTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var saveButton: UIButton!
    
    // MARK: Properties
    var onSaveAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(name: String, price: String, isWatchList: Bool) {
        self.nameLabel.text = name
        self.priceLabel.text = "$" + price
        self.saveButton.setImage(UIImage(systemName: isWatchList ?  "heart.fill" : "heart"), for: .normal)
    }
    
    @IBAction func saveButtonHandleTapped(_ sender: Any) {
        onSaveAction?()
    }
}
