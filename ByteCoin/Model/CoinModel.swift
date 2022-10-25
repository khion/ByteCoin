//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Rodnick Gayem on 2022-10-24.
//

import Foundation

struct CoinModel {
    let currency: String
    let coinType: String
    let rate: Double
    
    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
