//
//  BitCoinResponse.swift
//  BitCoinWatcher
//
//  Created by Sebastian Öberg on 2021-02-17.
//

import Foundation

struct BitCoinResponse: Codable {
    let data: BtcData
}

struct BtcData: Codable {
    let base: String
    let currency: String
    let amount: String
}
