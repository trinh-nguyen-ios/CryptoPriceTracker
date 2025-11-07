//
//  ViewController.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 5/11/25.
//

import UIKit
import RxSwift

final class PriceListViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var viewModel: PriceListViewModel?
    var priceList: [Crypto] = []
    let disposeBag = DisposeBag()
    
    static func instantiate(viewModel: PriceListViewModel, storyboardName: String = "PriceList") -> PriceListViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? PriceListViewController else {
            return nil
        }
        vc.viewModel = viewModel
        return vc
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bindViewModel()
    }
    
    private func configUI() {
        navigationController?.navigationBar.isHidden = false
        title = "Price list"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PriceListTableViewCell", bundle: nil), forCellReuseIdentifier: "CryptoCell")
    }
    
    private func bindViewModel() {
        let input = PriceListViewModel.Input(loadTrigger: Observable.just(()))
        
        guard let output = viewModel?.transForm(input: input) else { return }
        
        output.cryptoList.asObservable()
            .subscribe(onNext: { cryptoList in
                self.priceList = cryptoList
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        output.isLoading.asObservable()
            .subscribe(onNext: { isLoading in
                print("\(isLoading)")
            })
            .disposed(by: disposeBag)
        
        output.error.asObservable()
            .subscribe(onNext: { error in
                print("\(error)")
            })
            .disposed(by: disposeBag)
    }
}

extension PriceListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        priceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as? PriceListTableViewCell
        let name = priceList[indexPath.row].name
        let price = priceList[indexPath.row].usd.description
        
        cell?.set(name: name, price: price)
        return cell ?? UITableViewCell()
    }
}

