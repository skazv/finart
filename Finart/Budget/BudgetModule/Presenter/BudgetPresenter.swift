//
//  BudgetPresenter.swift
//  Finart
//
//  Created by Suren Kazaryan on 20.04.2022.
//

import Foundation
import UIKit

class BudgetPresenter: BudgetPresenterProtocol {
    var view: BudgetViewProtocol?
    var interactor: BudgetInteractorInputProtocol?
    var router: BudgetRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchCurrentBudget()
        interactor?.fetchCells(cellType: .income)
        interactor?.fetchCells(cellType: .account)
        interactor?.fetchCells(cellType: .spending)
        interactor?.fetchCurrencyRates()
    }
    
    func addCell(from view: BudgetViewProtocol, budgetId: Int, cellType: CellType, currency: String) {
        router?.presentAddCellScreen(from: view, budgetId: budgetId, cellType: cellType, currency: currency)
    }
    
    func deleteCell(budgetId: Int, cellType: CellType, row: Int) {
        interactor?.deleteCell(budgetId: budgetId, cellType: cellType, row: row)
    }
    
    func moveCell(budgetId: Int, cellType: CellType, source: Int, destinashion: Int) {
        interactor?.moveCell(budgetId: budgetId, cellType: cellType, source: source, destinashion: destinashion)
    }
    
    func showCell(from view: BudgetViewProtocol, budgetId: Int, cellType: CellType, row: Int) {
        router?.presentCellDetailScreen(from: view, budgetId: budgetId, cellType: cellType, row: row)
    }
    
    func makeTransaction(from view: BudgetViewProtocol, budgetId: Int, toCellType: CellType, fromCell: Int, toCell: Int) {
        router?.presentTransactionScreen(from: view, budgetId: budgetId, toCellType: toCellType, fromCell: fromCell, toCell: toCell)
    }
    
    func makeCurrencyTransaction(from view: BudgetViewProtocol, budgetId: Int, toCellType: CellType, fromCell: Int, toCell: Int) {
        router?.presentCurrencyTransactionScreen(from: view, budgetId: budgetId, toCellType: toCellType, fromCell: fromCell, toCell: toCell)
    }
    
    func showBudgetsTable(budgetId: Int) {
        guard let view = view else { return }
        router?.presentBudgetsTableScreen(from: view, budgetId: budgetId)
    }
    
    func showBudgetsBoard() {
        guard let view = view else { return }
        router?.presentBudgetsBoardScreen(from: view)
    }
    
}

//MARK: - BudgetInteractorOutputProtocol
extension BudgetPresenter: BudgetInteractorOutputProtocol {
    func didFetchCurrentBudget(budgetCD: BudgetCD) {
        guard let name = budgetCD.name else { return }
        guard let icon = budgetCD.icon else { return }
        guard let image = UIImage(systemName: icon) else { return }
        guard let reportDay = budgetCD.reportDate else { return }
        guard let currency = budgetCD.currency else { return }
        
        view?.didFetchCurrentBudget(budgetViewModel: BudgetViewModel(name: name,
                                                                     icon: image,
                                                                     reportDay: reportDay,
                                                                     currency: currency))
    }
    
    func didFetchIncomes(incomes: [IncomeCD]) {
        var incomeViewModels: [IncomeViewModel]
        incomeViewModels = incomes.map { incomeCD in
            return incomeCDtoIncomeVM(incomeCD: incomeCD)
        }
        view?.reloadIncomeView(with: incomeViewModels)
    }
    
    func didFetchAccounts(accounts: [AccountCD]) {
        var accountViewModels: [AccountViewModel]
        
        accountViewModels = accounts.map { accountCD in
//            if let name = accountCD.name {
//                if let icon = accountCD.icon {
//                    if let image = UIImage(systemName: icon) {
//                        return AccountViewModel(name: name, count: Int(accountCD.count), icon: image)
//                    }
//                }
//            }
            return accountCDtoAccountVM(accountCD: accountCD)//AccountViewModel(name: "Empty", count: 1, icon: .strokedCheckmark)
        }
        
        view?.reloadAccountView(with: accountViewModels)
    }
    
    func didFetchSpendings(spendings: [SpendingCD]) {
        var spendingViewModels: [SpendingViewModel]
        spendingViewModels = spendings.map { spendingCD in
            return spendingCDtoSpendingVM(spendingCD: spendingCD)
        }
        view?.reloadSpendingView(with: spendingViewModels)
    }
    
    func didDeleteIncome(row: Int) {
        view?.didDeleteIncome(row: row)
    }
    
    func didDeleteAccount(row: Int) {
        view?.didDeleteAccount(row: row)
    }
    
    func didDeleteSpending(row: Int) {
        view?.didDeleteSpending(row: row)
    }
    
    func didMoveCell(source: Int, destinashion: Int) {
        view?.didMoveCell(source: source, destinashion: destinashion)
    }

    func didMoveAccountCell(source: Int, destinashion: Int) {
        view?.didMoveAccountCell(source: source, destinashion: destinashion)
    }
    
    func didMoveSpendingCell(source: Int, destinashion: Int) {
        view?.didMoveSpendingCell(source: source, destinashion: destinashion)
    }
    
    func didFetchCurrencyRates(currencyRaw: CurrencyRaw) {
        print(currencyRaw.AMD)
    }
    
}

//MARK: - AddCellDelegate
extension BudgetPresenter: AddCellDelegate {
    func didSaveSpendingCell(spendingCD: SpendingCD) {
        guard let name = spendingCD.name else { return }
        guard let icon = spendingCD.icon else { return }
        guard let image = UIImage(systemName: icon) else { return }
        guard let currency = spendingCD.currency else { return }
        //CoreDATA ужастно!!!
        let count = CoreDataManager.giveRealCount(spendingCD: spendingCD)

        let spendingViewModel = SpendingViewModel(name: name,
                                                  count: count,
                                                  planCount: Int(spendingCD.planCount),
                                                  icon:image,
                                                  currency: currency)
        view?.didAddSpending(spendingViewModel: spendingViewModel)
    }
    
    
    func didAddCell(incomeCD: IncomeCD) {
        guard let name = incomeCD.name else { return }
        guard let icon = incomeCD.icon else { return }
        guard let image = UIImage(systemName: icon) else { return }
        guard let currency = incomeCD.currency else { return }
        //CoreDATA ужастно!!!
        let count = CoreDataManager.giveRealCount(incomeCD: incomeCD)

        let incomeViewModel = IncomeViewModel(name: name, count: count, planCount: Int(incomeCD.planCount), icon:image, currency: currency)
        view?.didAddIncome(incomeViewModel: incomeViewModel)
    }
    
    func didAddAccountCell(accountCD: AccountCD) {
        guard let name = accountCD.name else { return }
        guard let icon = accountCD.icon else { return }
        guard let image = UIImage(systemName: icon) else { return }
        guard let currency = accountCD.currency else { return }
        
        let accountViewModel = AccountViewModel(name: name, count: Int(accountCD.count), icon:image, currency: currency)
        view?.didAddAccount(accountViewModel: accountViewModel)
    }
    
}

//MARK: - TransactionDelegate
extension BudgetPresenter: TransactionDelegate {
    func didSaveTransaction(cellType: CellType, fromCellRow: Int, fromCellCount: Int, toCellRow: Int, toCellCount: Int) {
        view?.didTransactionCell(cellType: cellType,
                                 fromCellRow: fromCellRow,
                                 fromCellCount: fromCellCount,
                                 toCellRow: toCellRow,
                                 toCellCount: toCellCount)
    }
    
//    func didSaveTransaction(cellType: CellType, fromCellRow: Int, toCellRow: Int, count: Int) {
//        view?.didTransactionCell(cellType: cellType, fromCellRow: fromCellRow, toCellRow: toCellRow, count: count)
//    }
    
    func didClosed() {
        view?.didClosedTransaction()
    }

}

//MARK: - TransactionDelegate
extension BudgetPresenter: CurrencyTransactionDelegate {
    func didSaveCurrencyTransaction(cellType: CellType, fromCellRow: Int, fromCellCount: Int, toCellRow: Int, toCellCount: Int) {
        view?.didTransactionCell(cellType: cellType,
                                 fromCellRow: fromCellRow,
                                 fromCellCount: fromCellCount,
                                 toCellRow: toCellRow,
                                 toCellCount: toCellCount)
    }
    
    func didClosedCurrency() {
        view?.didClosedTransaction()
    }
    
}


//MARK: - CellDetailDelegate
extension BudgetPresenter: CellDetailDelegate {
    
    func deleteTransaction(cellType: CellType, fromCellRow: Int, fromCellCount: Int, toCellRow: Int, toCellCount: Int) {
        view?.didDeleteTransaction(cellType: cellType,
                                   fromCellRow: fromCellRow,
                                   fromCellCount: fromCellCount,
                                   toCellRow: toCellRow,
                                   toCellCount: toCellCount)
    }
    
    func didUpdateCell(cellType: CellType, incomeCD: IncomeCD?, accountCD: AccountCD?, spendingCD: SpendingCD?) {
        switch cellType {
        case .income:
            guard let incomeCD = incomeCD else { return }
            view?.didUpdateCell(cellType: cellType, cellRow: Int(incomeCD.id), income: incomeCDtoIncomeVM(incomeCD: incomeCD), account: nil, spending: nil)
        case .account:
            guard let accountCD = accountCD else { return }
            view?.didUpdateCell(cellType: cellType, cellRow: Int(accountCD.id), income: nil, account: accountCDtoAccountVM(accountCD: accountCD), spending: nil)
        case .spending:
            guard let spendingCD = spendingCD else { return }
            view?.didUpdateCell(cellType: cellType, cellRow: Int(spendingCD.id), income: nil, account: nil, spending: spendingCDtoSpendingVM(spendingCD: spendingCD))
        }
    }
    
//    func didUpdateCell(cellType: CellType, cellRow: Int, name: String, count: Int, icon: String) {
//        view?.didUpdateCell(cellType: cellType, cellRow: cellRow, name: name, count: count, icon: icon)
//    }
    
}


//MARK: - BudgetTablesDelegate
extension BudgetPresenter: BudgetTablesDelegate {
    func reloadAllItems(budgetId: Int) {
        interactor?.fetchCellsByBudget(budgetId: budgetId, cellType: .income)
        interactor?.fetchCellsByBudget(budgetId: budgetId, cellType: .account)
        interactor?.fetchCellsByBudget(budgetId: budgetId, cellType: .spending)
    }
    
    func openAddBudget() {
        guard let view = view else { return }
        router?.presentAddBudgetScreen(from: view)
    }
    
    func openUpdateBudget(budgetId: Int) {
        guard let view = view else { return }
        router?.presentUpdateBudgetScreen(from: view, budgetId: budgetId)
    }
    
}

//MARK: - BudgetsBoardDelegate ?? DELETE?
extension BudgetPresenter: BudgetsBoardDelegate {
}

//MARK: - AddBudgetDelegate
extension BudgetPresenter: AddBudgetDelegate {
    func didAddBudget(budgetCD: BudgetCD) {
        let budgetId = Int(budgetCD.id)
        
        reloadAllItems(budgetId: budgetId)
    }
    
}


//MARK: - UpdateBudgetDelegate
extension BudgetPresenter: UpdateBudgetDelegate {
    func didUpdateBudget(budgetCD: BudgetCD) {
        let budgetId = Int(budgetCD.id)
        
        reloadAllItems(budgetId: budgetId)
    }


}
