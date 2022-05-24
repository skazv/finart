//
//  CurrencyRaw.swift
//  Finart
//
//  Created by Suren Kazaryan on 22.05.2022.
//

import Foundation

struct CurrenciesRaw: Codable {
    let rates: CurrencyRaw
}

struct CurrencyRaw: Codable {
    let AMD: Double
    let USD: Double
    let EUR: Double
    let RUB: Double
}
