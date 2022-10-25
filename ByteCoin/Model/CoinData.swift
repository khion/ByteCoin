//
//  CoinData.swift
//  ByteCoin
//
//  Created by Rodnick Gayem on 2022-10-24.
//

import Foundation

struct CoinData: Codable {
    let rate: Double
    let asset_id_quote: String
    let asset_id_base: String
}
