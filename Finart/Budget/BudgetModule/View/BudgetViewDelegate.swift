//
//  BudgetViewDelegate.swift
//  Finart
//
//  Created by Suren Kazaryan on 26.04.2022.
//

import Foundation
import UIKit

protocol BudgetViewDelegate: AnyObject {
    func addCell(cellType: CellType)
    func deleteCell(cellType: CellType, row: Int)
    func moveCell(cellType: CellType, source: Int, destination: Int)
    func select(cellType: CellType, row: Int)
    func transaction(fromCellType: CellType, destinationRow: Int)
    //func didEnd(cellType: CellType)
}
