//
//  CurrencyResponse.swift
//  Finart
//
//  Created by Suren Kazaryan on 22.05.2022.
//

import Foundation

struct CurrencyResponse: Responsable {
    let rates: CurrenciesRaw
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(CurrenciesRaw.self)
        rates = value
    }
}
