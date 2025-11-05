//
//  ViewController.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 5/11/25.
//

import UIKit

final class PriceListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var priceList: [UsdCryptoDTO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        let data: UsdPricesResponseDTO = Utils.loadJSON(filename: "usdPrices")
        priceList = data.data
        tableView.reloadData()
    }
    
    private func configUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CryptoCell")
    }
}

extension PriceListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        priceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath)
        cell.textLabel?.text = priceList[indexPath.row].name + priceList[indexPath.row].usd.description
        return cell
    }
    
    
    
}

