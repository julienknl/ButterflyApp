//
//  ViewController.swift
//  Butterfly
//
//  Created by Julien on 27/11/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var products: [ProductOrder] = [] {
        didSet {
            //Use the main UI thread to load the data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private let cellIdentifier = "ProductCell"
    private let segueIdentifier = "ItemSegue"
    private var productId: Int?
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //Init the nib to use the custom cell
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        viewModel.productsLiveData = { [weak self] in
            self?.products = self?.viewModel.products ?? []
        }
    }
    
    @IBAction func addBtn(_ sender: Any) {
        viewModel.add()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            if let destination = segue.destination as? DetailViewController {
                destination.productId = productId
            }
        }
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        
        cell.set(data: products[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.productId = products[indexPath.row].id
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
}

