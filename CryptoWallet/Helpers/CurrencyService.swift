//
//  CryptoService.swift
//  CryptoWallet
//
//  Created by Ilya Kalin on 16.03.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
}

final class CurrencyService {
    private let baseURL = "https://data.messari.io/api/v1/assets"
    
    func fetchCurrencies(symbols: [String], completion: @escaping (Result<[Currency], Error>) -> Void) {
        let group = DispatchGroup()
        var currencies = [Currency]()
        
        symbols.forEach { symbol in
            group.enter()
            let url = URL(string: "\(baseURL)/\(symbol)/metrics")!
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                defer { group.leave() }
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let assetData = json["data"] as? [String: Any],
                      let symbol = assetData["symbol"] as? String,
                      let marketData = assetData["market_data"] as? [String: Any],
                      let price = marketData["price_usd"] as? Double,
                      let change = marketData["percent_change_usd_last_24_hours"] as? Double else {
                    return
                }
                
                let currency = Currency(
                    name: self.getName(for: symbol),
                    symbol: symbol,
                    price: price,
                    changePercent: change,
                    logoName: symbol.lowercased()
                )
                currencies.append(currency)
            }.resume()
        }
        
        group.notify(queue: .main) {
            completion(.success(currencies))
        }
    }
    
    private func getName(for symbol: String) -> String {
        switch symbol.lowercased() {
        case "btc": return "Bitcoin"
        case "eth": return "Ethereum"
        case "tron": return "TRON"
        case "luna": return "Terra"
        case "polkadot": return "Polkadot"
        case "dogecoin": return "Dogecoin"
        case "tether": return "Tether"
        case "stellar": return "Stellar"
        case "cardano": return "Cardano"
        case "xrp": return "XRP"
        default: return symbol
        }
    }
}
