//
//  HomeViewModel.swift
//  CryptoWallet
//
//  Created by Ilya Kalin on 16.03.2025.
//

import Foundation

protocol CurrencyViewModelProtocol: AnyObject {
    var currencies: [Currency] { get }
    var isLoading: Bool { get }
    var didUpdateData: (() -> Void)? { get set }
    var didChangeLoadingState: ((Bool) -> Void)? { get set }
    func fetchData()
    func toggleSort()
}

final class CurrencyViewModel: CurrencyViewModelProtocol {
    private let symbols = ["btc", "eth", "tron", "luna", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
    private let service = CurrencyService()
    private var isAscending = false
    
    var currencies: [Currency] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.didUpdateData?()
            }
        }
    }
    
    var isLoading = true {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.didChangeLoadingState?(self?.isLoading ?? false)
            }
        }
    }
    
    var didUpdateData: (() -> Void)?
    var didChangeLoadingState: ((Bool) -> Void)?
    
    func fetchData() {
        isLoading = true
        service.fetchCurrencies(symbols: symbols) { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.currencies = currencies
                print("Currencies fetched: \(currencies.count)")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            self?.isLoading = false
        }
    }
    
    func toggleSort() {
        isAscending.toggle()
        currencies.sort {
            isAscending ? $0.changePercent < $1.changePercent : $0.changePercent > $1.changePercent
        }
        didUpdateData?()
    }
}
