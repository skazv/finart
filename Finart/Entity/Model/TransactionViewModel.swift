//
//  TransactionViewModel.swift
//  Finart
//
//  Created by Suren Kazaryan on 29.04.2022.
//

import Foundation
import UIKit

struct TransactionViewModel {
    let identificator: UUID
    let name: String
    let icon: UIImage
    let count: Int
    let isSource: Bool
    let date: String
}
