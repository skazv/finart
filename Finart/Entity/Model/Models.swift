//
//  Model.swift
//  Finart
//
//  Created by Suren Kazaryan on 20.04.2022.
//

import UIKit

struct BudgetViewModel {
    let name: String
    let icon: UIImage
    let reportDay: Date
    let currency: String
}

enum Currencys {
    case rub
    case usd
    case eur
    case amd
}

enum Colors {
    case black
    case white
}

struct CurrencyViewModel {
    let shortName: String
    let name: String
    let symbol: String
}
