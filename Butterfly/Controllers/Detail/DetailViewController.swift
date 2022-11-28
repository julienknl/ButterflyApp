//
//  DetailViewController.swift
//  Butterfly
//
//  Created by Julien on 28/11/2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var items: [ProductItem] = []
    
    private let cellIdentifier = "ProductCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        //Init the nib to use the custom cell
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
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
