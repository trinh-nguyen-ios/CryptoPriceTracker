//
//  PriceListViewModelTests.swift
//  CryptoPriceTrackerTests
//
//  Created by Nguyen The Trinh on 8/11/25.
//

@testable import CryptoPriceTracker
import RxSwift
import XCTest

final class PriceListViewModelTests: XCTestCase {

    var viewModel: PriceListViewModel!
    var useCase: MockFetchUSDPriceUseCase!
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        self.useCase = MockFetchUSDPriceUseCase()
//        self.viewModel = PriceListViewModel(useCase: useCase)
    }
    
    func test_load_trigger_return_crypto_list() {
        //given
//        let loadTrigger = PublishSubject<Void>()
//        let input = PriceListViewModel.Input(loadTrigger: loadTrigger)
//        var result: [Crypto] = []
//        let output = viewModel.transForm(input: input)
//        
//        output.cryptoList.asObservable()
//            .subscribe(onNext: {
//                result = $0
//            })
//            .disposed(by: disposeBag)
//        
//        //when
//        loadTrigger.onNext(())
//        
//        //then
//        XCTAssertEqual(result.count, 1)
    }
    
}

class MockFetchUSDPriceUseCase: FetchUSDPriceListUseCaseType {
    var stubble = [Crypto(id: 1, name: "BTC", usd: 1000, eur: nil, tags: ["Tag1"])]
    func execute() -> Observable<[Crypto]> {
        return .just(stubble)
    }
}
