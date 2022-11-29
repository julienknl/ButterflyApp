//
//  AddItemViewController.swift
//  Butterfly
//
//  Created by Julien on 29/11/2022.
//

import UIKit

protocol ProductDelegate: AnyObject {
    func didComplete()
}

class AddItemViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var productId: Int?
    
    weak var delegate: ProductDelegate?
    
    private let viewModel = AddItemModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addBtn(_ sender: Any) {
        guard let id = productId, let quantity = textField.text else {
            print("Error while adding new item")
            return
        }
        viewModel.add(productId: id, quantity: Int(quantity) ?? 0) { [weak self] in
            self?.delegate?.didComplete()
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
