//
//  InvoiceViewController.swift
//  Butterfly
//
//  Created by Julien on 29/11/2022.
//

import UIKit

class InvoiceViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var invoices: [ProductInvoice] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var productId: Int?
    private lazy var viewModel = InvoiceViewModel(productId: productId ?? -1)
    
    private let cellIdentifier = "ProductCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        //Init the nib to use the custom cell
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        viewModel.invoiceLiveData = { [weak self] in
            self?.invoices = self?.viewModel.invoices ?? []
        }
    }

}

extension InvoiceViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        
        cell.set(data: invoices[indexPath.row])
        
        return cell
    }

}
