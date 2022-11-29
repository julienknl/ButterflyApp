//
//  DetailViewController.swift
//  Butterfly
//
//  Created by Julien on 28/11/2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var items: [ProductItem] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private let cellIdentifier = "ProductCell"
    private let segueIdentifier = "InvoiceSegue"
    
    var productId: Int?
    private lazy var viewModel = DetailViewModel(productId: productId ?? -1)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        //Init the nib to use the custom cell
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        viewModel.itemLiveData = { [weak self] in
            self?.items = self?.viewModel.items ?? []
        }
        
    }
    
    @IBAction func invoiceBtn(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "InvoiceStoryboard") as? InvoiceViewController, productId != nil {
            controller.productId = productId
            present(controller, animated: true, completion: nil)
        }
        else {
            print("Error no product id found")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            if let destination = segue.destination as? InvoiceViewController {
                destination.productId = productId
            }
        }
    }

}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        
        cell.set(data: items[indexPath.row])
        
        return cell
    }
    
}
