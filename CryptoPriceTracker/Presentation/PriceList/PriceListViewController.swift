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
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Properties
    var viewModel: PriceListViewModel
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
        self.viewModel = PriceListViewModel(useCase: FetchPriceListUseCase(userDefault: .standard))
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bindViewModel()
    }
    
    private func configUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CryptoCell")
    }
    
    private func bindViewModel() {
        let input = PriceListViewModel.Input(searchTrigger:
                                                Observable
                                                    .merge(
                                                        Observable.just(""),
                                                        searchBar.rx.text.orEmpty.asObservable()
                                                    ))
        
        let output = viewModel.transForm(input: input)
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath)
        cell.textLabel?.text = String(format: "Code: %@ -- Price: %@ USD", arguments: [priceList[indexPath.row].name,  priceList[indexPath.row].usd.description])
        return cell
    }
}

