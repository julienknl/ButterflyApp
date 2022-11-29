//
//  ProductTableViewCell.swift
//  Butterfly
//
//  Created by Julien on 27/11/2022.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //Setter for product order
    func set(data: ProductOrder) {
        DispatchQueue.main.async { [unowned self] in
            idLabel.text = "ID: \(data.id ?? -1)"
            dateLabel.text = "Updated on: \(data.last_updated?.convertToReadableDate() ?? "NaN")"
            quantityLabel.text = "Quantity: \(data.itemsCount)"
        }
    }
    
    //Setter for product items
    func set(data: ProductItem) {
        DispatchQueue.main.async { [unowned self] in
            idLabel.text = "ID: \(data.id ?? -1)"
            dateLabel.isHidden = true
            quantityLabel.text = "Quantity: \(data.quantity ?? 0)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
