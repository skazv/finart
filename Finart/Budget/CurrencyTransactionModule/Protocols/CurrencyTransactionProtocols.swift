//
//  CurrencyTransactionProtocols.swift
//  Finart
//
//  Created by Suren Kazaryan on 19.05.2022.
//

import UIKit

protocol CurrencyTransactionDelegate: AnyObject {
    func didSaveCurrencyTransaction(cellType: CellType, fromCellRow: Int, fromCellCount: Int, toCellRow: Int, toCellCount: Int)
    func didClosedCurrency()
}

protocol CurrencyTransactionViewProtocol: AnyObject {
    var presenter: CurrencyTransactionPresenterProtocol? { get set }

    // PRESENTER -> VIEW
    func reloadIncome(with incomeViewModel: IncomeViewModel)
    func reloadAccount(with accountViewModel: AccountViewModel)
    func reloadSpending(with spendingViewModel: SpendingViewModel)
}

protocol CurrencyTransactionPresenterProtocol: AnyObject {
    var view: CurrencyTransactionViewProtocol? { get set }
    var interactor: CurrencyTransactionInteractorInputProtocol? { get set }
    var router: CurrencyTransactionRouterProtocol? { get set }
    var delegate: CurrencyTransactionDelegate? { get set }
    var budgetId: Int? { get set }
    var fromCell: Int? { get set }
    var toCell: Int? { get set }
    var toCellType: CellType? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func addTransaction(fromCell: Int, toCell: Int, name: String, count: Int, secondCount: Int, date: Date)
    func closeView()
}

protocol CurrencyTransactionRouterProtocol: AnyObject {
    static func createCurrencyTransactionModul(with delegate: CurrencyTransactionDelegate, budgetId: Int, toCellType: CellType, fromCell: Int, toCell: Int) -> UIViewController
    
    // PRESENTER -> ROUTER
    func dismissCurrencyTransaction(from view: CurrencyTransactionViewProtocol, completion: (() -> Void)?)
}

protocol CurrencyTransactionInteractorInputProtocol: AnyObject {
    var presenter: CurrencyTransactionInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchCell(budgetId: Int, cellType: CellType, row: Int)
    func saveTransaction(budgetId: Int, toCellType: CellType, fromCell: Int, toCell: Int, name: String, count: Int, secondCount: Int, date: Date)
}

protocol CurrencyTransactionInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didFetchIncome(income: IncomeCD)
    func didFetchAccount(account: AccountCD)
    func didFetchSpending(spending: SpendingCD)
    
    func didSaveTransaction(cellType: CellType, fromCellRow: Int, fromCellCount: Int, toCellRow: Int, toCellCount: Int)
}
