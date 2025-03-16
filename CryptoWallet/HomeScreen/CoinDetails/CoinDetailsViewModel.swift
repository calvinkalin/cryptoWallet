//
//  CoinDetailsViewModel.swift
//  CryptoWallet
//
//  Created by Ilya Kalin on 16.03.2025.
//

import Foundation

class CoinDetailsViewModel {
    let coin: Currency
    
    init(coin: Currency) {
        self.coin = coin
    }
    
    var name: String {
        return coin.name
    }
    
    var symbol: String {
        return "(\(coin.symbol.uppercased()))"
    }
    
    var price: String {
        return "$\(coin.price)"
    }
    
    var priceChange: String {
        return "\(coin.changePercent)%"
    }
    
    var isPriceUp: Bool {
        return coin.changePercent > 0
    }
    
//    var marketCap: String {
//        return "$\(coin.marketCap)"
//    }
//    
//    var circulatingSupply: String {
//        return "\(coin.circulatingSupply) \(coin.symbol.uppercased())"
//    }
}
