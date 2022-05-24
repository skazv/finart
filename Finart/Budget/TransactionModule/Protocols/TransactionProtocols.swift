//
//  Protocols.swift
//  Finart
//
//  Created by Suren Kazaryan on 20.04.2022.
//

import UIKit

protocol TransactionDelegate: AnyObject {
    //func didSaveTransaction(cellType: CellType, fromCellRow: Int, toCellRow: Int, count: Int)
    func didSaveTransaction(cellType: CellType, fromCellRow: Int, fromCellCount: Int, toCellRow: Int, toCellCount: Int)
    func didClosed()
}

protocol TransactionViewProtocol: AnyObject {
    var presenter: TransactionPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func reloadIncome(with incomeViewModel: IncomeViewModel)
    func reloadAccount(with accountViewModel: AccountViewModel)
    func reloadSpending(with spendingViewModel: SpendingViewModel)

}

protocol TransactionPresenterProtocol: AnyObject {
    var view: TransactionViewProtocol? { get set }
    var interactor: TransactionInteractorInputProtocol? { get set }
    var router: TransactionRouterProtocol? { get set }
    var delegate: TransactionDelegate? { get set }
    var budgetId: Int? { get set }
    var fromCell: Int? { get set }
    var toCell: Int? { get set }
    var toCellType: CellType? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func closeView()
    func addTransaction(fromCell: Int, toCell: Int, name: String, count: Int, date: Date)
}

protocol TransactionRouterProtocol: AnyObject {
    static func createTransactionModul(with delegate: TransactionDelegate, budgetId: Int, toCellType: CellType, fromCell: Int, toCell: Int) -> UIViewController
    
    // PRESENTER -> ROUTER
    func dismissAddCell(from view: TransactionViewProtocol, completion: (() -> Void)?)
}

protocol TransactionInteractorInputProtocol: AnyObject {
    var presenter: TransactionInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchCell(budgetId: Int, cellType: CellType, row: Int)
    func saveTransaction(budgetId: Int, toCellType: CellType, fromCell: Int, toCell: Int, name: String, count: Int, date: Date)

}

protocol TransactionInteractorOutputProtocol: AnyObject {
    
    //INTERACTOR -> PRESENTER
    func didFetchIncome(income: IncomeCD)
    func didFetchAccount(account: AccountCD)
    func didFetchSpending(spending: SpendingCD)
    
    func didSaveTransaction(cellType: CellType, fromCellRow: Int, fromCellCount: Int, toCellRow: Int, toCellCount: Int)
}
