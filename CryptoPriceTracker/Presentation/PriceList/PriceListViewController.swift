//
//  ViewController.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 5/11/25.
//

import UIKit
import RxSwift
import RxCocoa

final class PriceListViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Properties
    var viewModel: PriceListViewModel?
    var priceList: [PriceListModel] = []
    let disposeBag = DisposeBag()
    private let toogleWatchedList = PublishSubject<Crypto>()
    private let tapCell = PublishSubject<Crypto>()
    
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
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bindViewModel() {
        let searchTrigger = Observable.merge([Observable.just(""),  searchBar.rx.text.orEmpty.asObservable()])
        let input = PriceListViewModel.Input(searchTrigger: searchTrigger, toggleWatchedList: toogleWatchedList.asObservable(), tapCell: tapCell.asObservable())
        
        guard let output = viewModel?.transForm(input: input) else { return }
        
        output.cryptoList.asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { model in
                self.priceList = model
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
        let model = priceList[indexPath.row]
        
        cell?.set(name: model.crypto.name, price: model.crypto.usd.description, isWatchList: model.isWatchedList)
        cell?.onSaveAction = { [weak self] in
            self?.toogleWatchedList.onNext(model.crypto)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tapCell.onNext(priceList[indexPath.row].crypto)
    }
}

