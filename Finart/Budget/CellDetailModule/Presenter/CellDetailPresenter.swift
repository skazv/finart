//
//  CellDetailPresenter.swift
//  Finart
//
//  Created by Suren Kazaryan on 26.04.2022.
//

import Foundation
import UIKit

class CellDetailPresenter: CellDetailPresenterProtocol {
    var view: CellDetailViewProtocol?
    var interactor: CellDetailInteractorInputProtocol?
    var router: CellDetailRouterProtocol?
    var delegate: CellDetailDelegate?
    var budgetId: Int?
    var cellType: CellType?
    var row: Int?
    
    func viewDidLoad() {
        guard let cellType = cellType else { return }
        guard let row = row else { return }
        guard let budgetId = budgetId else { return }

        interactor?.fetchCell(budgetId: budgetId, cellType: cellType, row: row)
        interactor?.fetchTransactions(budgetId: budgetId, cellType: cellType, row: row)
    }
    
    func updateCell(from view: CellDetailViewProtocol, cellType: CellType, cellRow: Int) {
        guard let budgetId = budgetId else { return }

        router?.presentUpdateCellScreen(from: view, budgetId: budgetId, cellType: cellType, cellRow: cellRow)
    }
    
    func deleteTransaction(identificator: UUID) {
        guard let cellType = cellType else { return }
        interactor?.deleteTransaction(celltype: cellType, identificator: identificator)
    }
    
}

extension CellDetailPresenter: CellDetailInteractorOutputProtocol {
    func didFetchIncome(income: IncomeCD) {
        guard let name = income.name else { return }
        guard let icon = income.icon else { return }
        guard let image = UIImage(systemName: icon) else { return }
        guard let currency = income.currency else { return }
        //Ужастно
        let realCount = CoreDataManager.giveRealCount(incomeCD: income)
        //Ужастно
        
        
        let viewModel = IncomeViewModel(name: name, count: realCount, planCount: Int(income.planCount), icon: image, currency: currency)
        view?.reloadIncome(with: viewModel)
    }
    
    func didFetchAccount(account: AccountCD) {
        guard let name = account.name else { return }
        guard let icon = account.icon else { return }
        guard let image = UIImage(systemName: icon) else { return }
        guard let currency = account.currency else { return }
        
        let viewModel = AccountViewModel(name: name, count: Int(account.count), icon: image, currency: currency)
        view?.reloadAccount(with: viewModel)
    }
    
    func didFetchSpending(spending: SpendingCD) {
        guard let name = spending.name else { return }
        guard let icon = spending.icon else { return }
        guard let image = UIImage(systemName: icon) else { return }
        guard let currency = spending.currency else { return }
        //Ужастно
        let realCount = CoreDataManager.giveRealCount(spendingCD: spending)
        //Ужастно
        
        let viewModel = SpendingViewModel(name: name, count: realCount, planCount: Int(spending.planCount), icon: image, currency: currency)
        view?.reloadSpending(with: viewModel)
    }
    
    func didFetchTransactions(transactions: [TransactionCD]) {
        let transactionViewModels: [TransactionViewModel]
        guard let cellType = cellType else { return }
        guard let budgetId = budgetId else { return }
        let budget = getBudget(budgetId: budgetId)
        
        switch cellType {
        case .income:
            view?.isIncome = true
            transactionViewModels = transactions.map({ transactionCD in
                let icon = UIImage(systemName: transactionCD.accountTransaction?.icon ?? "trash") ?? .remove
                let name = transactionCD.accountTransaction?.name ?? ""
                return TransactionViewModel(identificator: transactionCD.identificator,
                                            name: name,
                                            icon: icon,
                                            count: Int(transactionCD.count), isSource: true,
                                            date: transactionCD.date?.formatted() ?? "")
            })
            view?.reloadTransactions(transactions: transactionViewModels)
        case .account:
            
            let accountsCD = try? CoreDataManager.fetchAccountsByBudget(budget: budget)
            guard let accountsCD = accountsCD else { return }
            let accountCD = accountsCD[row ?? 0]
            var icon = UIImage(systemName: "trash")
            var name = ""
            var isSource = true
            transactionViewModels = transactions.map({ transactionCD in
                if accountCD === transactionCD.accountDestination {
                    icon = UIImage(systemName: transactionCD.accountTransaction?.icon ?? "trash") ?? .remove
                    name = transactionCD.accountTransaction?.name ?? ""
                    isSource = true
                } else if accountCD === transactionCD.accountTransaction {
                    if let incomeCD = transactionCD.incomeTransaction {
                        icon = UIImage(systemName: incomeCD.icon ?? "trash") ?? .remove
                        name = incomeCD.name ?? ""
                        isSource = true
                    } else if let spendingCD = transactionCD.spendingTransaction {
                        icon = UIImage(systemName: spendingCD.icon ?? "trash") ?? .remove
                        name = spendingCD.name ?? ""
                        isSource = false
                    } else {
                        icon = UIImage(systemName: transactionCD.accountDestination?.icon ?? "trash") ?? .remove
                        name = transactionCD.accountDestination?.name ?? ""
                        isSource = false
                    }
                } else {
                    print("WTF?")
                }
                return TransactionViewModel(identificator: transactionCD.identificator,
                                            name: name,
                                            icon: icon ?? .remove,
                                            count: Int(transactionCD.count),
                                            isSource: isSource,
                                            date: transactionCD.date?.formatted() ?? "")
            })
            view?.reloadTransactions(transactions: transactionViewModels)
        case .spending:
            view?.isIncome = false
            transactionViewModels = transactions.map({ transactionCD in
                let icon = UIImage(systemName: transactionCD.accountTransaction?.icon ?? "trash") ?? .remove
                let name = transactionCD.accountTransaction?.name ?? ""
                return TransactionViewModel(identificator: transactionCD.identificator,
                                            name: name,
                                            icon: icon,
                                            count: Int(transactionCD.count), isSource: false,
                                            date: transactionCD.date?.formatted() ?? "")
            })
            view?.reloadTransactions(transactions: transactionViewModels)
        }
        
        //view?.reloadTransactions(transactions: transactionViewModels)
    }
    
    func didDeleteTransaction(cellType: CellType, fromCellRow: Int, fromCellCount: Int, toCellRow: Int, toCellCount: Int) {
        delegate?.deleteTransaction(cellType: cellType,
                                    fromCellRow: fromCellRow,
                                    fromCellCount: fromCellCount,
                                    toCellRow: toCellRow,
                                    toCellCount: toCellCount)
    }
    
}

//MARK: - UpdateCellDelegate
extension CellDetailPresenter: UpdateCellDelegate {
    func didUpdateCell(cellType: CellType, incomeCD: IncomeCD?, accountCD: AccountCD?, spendingCD: SpendingCD?) {
        switch cellType {
        case .income:
            guard let incomeCD = incomeCD else { return }
            didFetchIncome(income: incomeCD)
        case .account:
            guard let accountCD = accountCD else { return }
            didFetchAccount(account: accountCD)
        case .spending:
            guard let spendingCD = spendingCD else { return }
            didFetchSpending(spending: spendingCD)
        }
        delegate?.didUpdateCell(cellType: cellType, incomeCD: incomeCD, accountCD: accountCD, spendingCD: spendingCD)
    }
    
//    func didUpdateCell(cellType: CellType, cellRow: Int, name: String, count: Int, icon: String) {
//        guard let image = UIImage(systemName: icon) else { return }
//
//        switch cellType {
//        case .income:
//            //Ужастно
//            //let realCount = CoreDataManager.giveRealCount(incomeCD: income)
//            //Ужастно
//            view?.reloadIncome(with: IncomeViewModel(name: name, count: 0, planCount: count, icon: image))
//            delegate?.didUpdateCell(cellType: cellType, cellRow: cellRow, name: name, count: count, icon: icon)
//        case .account:
//            view?.reloadAccount(with: AccountViewModel(name: name, count: count, icon: image))
//            delegate?.didUpdateCell(cellType: cellType, cellRow: cellRow, name: name, count: count, icon: icon)
//        case .spending:
//            //Ужастно
//           // let realCount = CoreDataManager.giveRealCount(spendingCD: : income)
//            //Ужастно
//            view?.reloadSpending(with: SpendingViewModel(name: name, count: 0, planCount: count, icon: image))
//            delegate?.didUpdateCell(cellType: cellType, cellRow: cellRow, name: name, count: count, icon: icon)
//        }
//    }
    
}
