//
//  budgetProtocols.swift
//  Finart
//
//  Created by Suren Kazaryan on 20.04.2022.
//

import UIKit

protocol BudgetViewProtocol: AnyObject {
    var presenter: BudgetPresenterProtocol? { get set }
    var source: Int? { get set }
    var destination: Int? { get set }
    var currencyRate: CurrencyRaw? { get set }

    // PRESENTER -> VIEW
    func reloadIncomeView(with incomeViewModels: [IncomeViewModel])
    func didAddIncome(incomeViewModel: IncomeViewModel)
    func didDeleteIncome(row: Int)
    
    func reloadAccountView(with accountViewModels: [AccountViewModel])
    func didAddAccount(accountViewModel: AccountViewModel)
    func didDeleteAccount(row: Int)
    
    //SPENDING
    func reloadSpendingView(with spendingViewModels: [SpendingViewModel])
    func didAddSpending(spendingViewModel: SpendingViewModel)
    func didDeleteSpending(row: Int)
    func didMoveSpendingCell(source: Int, destinashion: Int)
    
    func didMoveCell(source: Int, destinashion: Int)
    func didMoveAccountCell(source: Int, destinashion: Int)

    //func didTransactionCell(cellType: CellType, fromCellRow: Int, toCellRow: Int, count: Int)
    func didTransactionCell(cellType: CellType, fromCellRow: Int, fromCellCount: Int, toCellRow: Int, toCellCount: Int)
    func didClosedTransaction()
    
    //func didUpdateCell(cellType: CellType, cellRow: Int, name: String, count: Int, icon: String)
    func didUpdateCell(cellType: CellType, cellRow: Int, income: IncomeViewModel?, account: AccountViewModel?, spending: SpendingViewModel?)
    func didDeleteTransaction(cellType: CellType, fromCellRow: Int, fromCellCount: Int, toCellRow: Int, toCellCount: Int)
    
    func didAddBudget(budget: BudgetViewModel)
    func didFetchCurrentBudget(budgetViewModel: BudgetViewModel)
    func didFetchCurrencyRates(currencyRaw: CurrencyRaw)
}

protocol BudgetPresenterProtocol: AnyObject {
    var view: BudgetViewProtocol? { get set }
    var interactor: BudgetInteractorInputProtocol? { get set }
    var router: BudgetRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func addCell(from view: BudgetViewProtocol, budgetId: Int, cellType: CellType, currency: String)
    func deleteCell(budgetId: Int, cellType: CellType, row: Int)
    func moveCell(budgetId: Int, cellType: CellType, source: Int, destinashion: Int)
    func showCell(from view: BudgetViewProtocol, budgetId: Int, cellType: CellType, row: Int)
    
    func makeTransaction(from view: BudgetViewProtocol, budgetId: Int, toCellType: CellType, fromCell: Int, toCell: Int)
    func makeCurrencyTransaction(from view: BudgetViewProtocol, budgetId: Int, toCellType: CellType, fromCell: Int, toCell: Int)
    func showBudgetsTable(budgetId: Int)
    func showBudgetsBoard()
}

protocol BudgetRouterProtocol: AnyObject {
 //   static func createBudgetModul() -> UIViewController

    // PRESENTER -> ROUTER
    func presentAddCellScreen(from view: BudgetViewProtocol, budgetId: Int, cellType: CellType, currency: String)
    func presentCellDetailScreen(from view: BudgetViewProtocol, budgetId: Int, cellType: CellType, row: Int)
    func presentTransactionScreen(from view: BudgetViewProtocol, budgetId: Int, toCellType: CellType, fromCell: Int, toCell: Int)
    func presentCurrencyTransactionScreen(from view: BudgetViewProtocol, budgetId: Int, toCellType: CellType, fromCell: Int, toCell: Int)
    func presentBudgetsTableScreen(from view: BudgetViewProtocol, budgetId: Int)
    func presentBudgetsBoardScreen(from view: BudgetViewProtocol)
    func presentAddBudgetScreen(from view: BudgetViewProtocol)
    func presentUpdateBudgetScreen(from view: BudgetViewProtocol, budgetId: Int)
}

protocol BudgetInteractorInputProtocol: AnyObject {
    var presenter: BudgetInteractorOutputProtocol? { get set }

    // PRESENTER -> INTERACTOR
    func fetchCurrentBudget()
    func fetchCellsByBudget(budgetId: Int, cellType: CellType)
    func fetchCells(cellType: CellType)
    func deleteCell(budgetId: Int, cellType: CellType, row: Int)
    func moveCell(budgetId: Int, cellType: CellType, source: Int, destinashion: Int)
    func fetchCurrencyRates()
}

protocol BudgetInteractorOutputProtocol: AnyObject {

    // INTERACTOR -> PRESENTER
    func didFetchCurrentBudget(budgetCD: BudgetCD)
    func didFetchIncomes(incomes: [IncomeCD])
    func didFetchAccounts(accounts: [AccountCD])
    func didFetchSpendings(spendings: [SpendingCD])
    func didDeleteIncome(row: Int)
    func didDeleteAccount(row: Int)
    func didDeleteSpending(row: Int)
    func didMoveCell(source: Int, destinashion: Int)
    func didMoveAccountCell(source: Int, destinashion: Int)
    func didMoveSpendingCell(source: Int, destinashion: Int)
    func didFetchCurrencyRates(currencyRaw: CurrencyRaw)
}
