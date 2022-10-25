//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Rodnick Gayem on 2022-10-24.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateBitcoin(_ coinManger: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "FF6D5CD8-8776-4F17-92A2-3D97F780C983"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            //        Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }

                if let safeData = data {
                    if let coin = self.parseJSON(safeData) {
                        delegate?.didUpdateBitcoin(self, coin: coin)
                    }
                }
            
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let currency = decodedData.asset_id_quote
            let coinType = decodedData.asset_id_base
            let currencyRate = decodedData.rate
            
            let coin = CoinModel(currency: currency, coinType: coinType, rate: currencyRate)
            
            return coin
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
