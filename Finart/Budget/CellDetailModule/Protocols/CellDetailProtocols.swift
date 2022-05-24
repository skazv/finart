//
//  CellDetailProtocols.swift
//  Finart
//
//  Created by Suren Kazaryan on 26.04.2022.
//

import UIKit

protocol CellDetailDelegate: AnyObject {
    //func didUpdateCell(cellType: CellType, cellRow: Int, name: String, count: Int, icon: String)
    func didUpdateCell(cellType: CellType, incomeCD: IncomeCD?, accountCD: AccountCD?, spendingCD: SpendingCD?)
    func deleteTransaction(cellType: CellType, fromCellRow: Int, fromCellCount: Int, toCellRow: Int, toCellCount: Int)
}

protocol CellDetailViewProtocol: AnyObject {
    var presenter: CellDetailPresenterProtocol? { get set }
    var isIncome: Bool? { get set }

    // PRESENTER -> VIEW
    func reloadIncome(with incomeViewModel: IncomeViewModel)
    func reloadAccount(with accountViewModel: AccountViewModel)
    func reloadSpending(with spendingViewModel: SpendingViewModel)
    func reloadTransactions(transactions: [TransactionViewModel])

}

protocol CellDetailPresenterProtocol: AnyObject {
    var view: CellDetailViewProtocol? { get set }
    var interactor: CellDetailInteractorInputProtocol? { get set }
    var router: CellDetailRouterProtocol? { get set }
    var delegate: CellDetailDelegate? { get set }
    var budgetId: Int? { get set }
    var cellType: CellType? { get set }
    var row: Int? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func updateCell(from view: CellDetailViewProtocol, cellType: CellType, cellRow: Int)
    func deleteTransaction(identificator: UUID)
}

protocol CellDetailRouterProtocol: AnyObject {
    static func createCellDetailModul(with delegate: CellDetailDelegate, budgetId: Int, cellType: CellType, row: Int) -> UIViewController
    
    // PRESENTER -> ROUTER
    func presentUpdateCellScreen(from view: CellDetailViewProtocol, budgetId: Int, cellType: CellType, cellRow: Int)
    func dismissCellDetail(from view: CellDetailViewProtocol, completion: (() -> Void)?)
}

protocol CellDetailInteractorInputProtocol: AnyObject {
    var presenter: CellDetailInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchCell(budgetId: Int, cellType: CellType, row: Int)
    func fetchTransactions(budgetId: Int, cellType: CellType, row: Int)
    func deleteTransaction(celltype: CellType, identificator: UUID)
}

protocol CellDetailInteractorOutputProtocol: AnyObject {
    func didFetchIncome(income: IncomeCD)
    func didFetchAccount(account: AccountCD)
    func didFetchSpending(spending: SpendingCD)
    func didFetchTransactions(transactions: [TransactionCD])
    func didDeleteTransaction(cellType: CellType, fromCellRow: Int, fromCellCount: Int, toCellRow: Int, toCellCount: Int)
}
