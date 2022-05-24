//
//  CellDetailInteractor.swift
//  Finart
//
//  Created by Suren Kazaryan on 26.04.2022.
//

import Foundation

class CellDetailInteractor: CellDetailInteractorInputProtocol {
    var presenter: CellDetailInteractorOutputProtocol?
    
    func fetchCell(budgetId: Int, cellType: CellType, row: Int) {
        let budget = getBudget(budgetId: budgetId)
        
        switch cellType {
        case .income:
            let incomesCD = try? CoreDataManager.fetchIncomesByBudget(budget: budget)
            guard let incomesCD = incomesCD else { return }
            presenter?.didFetchIncome(income: incomesCD[row])
        case .account:
            let accountsCD = try? CoreDataManager.fetchAccountsByBudget(budget: budget)
            guard let accountsCD = accountsCD else { return }
            presenter?.didFetchAccount(account: accountsCD[row])
        case .spending:
            let spendingsCD = try? CoreDataManager.fetchSpendingsByBudget(budget: budget)
            guard let spendingsCD = spendingsCD else { return }
            presenter?.didFetchSpending(spending: spendingsCD[row])
        }
    }
    
    func fetchTransactions(budgetId: Int, cellType: CellType, row: Int) {
        let budget = getBudget(budgetId: budgetId)
        switch cellType {
        case .income:
            let incomesCD = try? CoreDataManager.fetchIncomesByBudget(budget: budget)
            guard let incomesCD = incomesCD else { return }
            let transactionsCD = try? CoreDataManager.fetchTransactions(income: incomesCD[row])
            if let transactionsCD = transactionsCD {
                presenter?.didFetchTransactions(transactions: transactionsCD)
            }
        case .account:
            let accountsCD = try? CoreDataManager.fetchAccountsByBudget(budget: budget)
            guard let accountsCD = accountsCD else { return }
            
            let transactionsCD = try? CoreDataManager.fetchTransactions(account: accountsCD[row])
            let destinationTransactions = try? CoreDataManager.fetchTransactions(accountDestination: accountsCD[row])
            if let transactionsCD = transactionsCD, let destinationTransactions = destinationTransactions {
                let unionTransactions = transactionsCD + destinationTransactions
                let sortedTransactions = unionTransactions.sorted { t1, t2 in
                    if let date1 = t1.date, let date2 = t2.date {
                        if date1 > date2 {
                            return true
                        }
                    }
                    return false
                }
                presenter?.didFetchTransactions(transactions: sortedTransactions)
            }
        case .spending:
            let spendingsCD = try? CoreDataManager.fetchSpendingsByBudget(budget: budget)
            guard let spendingsCD = spendingsCD else { return }
            let transactionsCD = try? CoreDataManager.fetchTransactions(spending: spendingsCD[row])
            if let transactionsCD = transactionsCD {
                presenter?.didFetchTransactions(transactions: transactionsCD)
            }
        }
    }
    
    func deleteTransaction(celltype: CellType, identificator: UUID) {
        var from = 0
        var to = 0
        if let transaction = try? CoreDataManager.fetchTransactions(identificator: identificator) {
            
            if transaction.incomeTransaction != nil {
                from = Int(transaction.incomeTransaction?.id ?? 0)
                to = Int(transaction.accountTransaction?.id ?? 0)
                guard let incomeCD = transaction.incomeTransaction else { return }
                guard let accountCD = transaction.accountTransaction else { return }
                
                var secondCount = 0
                if isSameCurrency(incomCD: incomeCD, accountCD: accountCD) {
                    secondCount = Int(transaction.count)
                } else {
                    secondCount = Int(transaction.secondCount)
                }
                
                let count = CoreDataManager.deleteTransaction(identificator: identificator)
                let incomeCount = CoreDataManager.giveRealCount(incomeCD: incomeCD)
                
                presenter?.didDeleteTransaction(cellType: .income,
                                                fromCellRow: from,
                                                fromCellCount: incomeCount,
                                                toCellRow: to,
                                                toCellCount: secondCount)
            } else if transaction.spendingTransaction != nil {
                from = Int(transaction.spendingTransaction?.id ?? 0)
                to = Int(transaction.accountTransaction?.id ?? 0)
//                guard let accountCD = transaction.accountTransaction else { return }
                guard let spendingCD = transaction.spendingTransaction else { return }
                
//                var secondCount = 0
//                if isSameCurrency(accountCD: accountCD, spendingCD: spendingCD) {
//                    secondCount = Int(transaction.count)
//                } else {
//                    secondCount = Int(transaction.secondCount)
//                }
                
                let count = CoreDataManager.deleteTransaction(identificator: identificator)
                let spendingCount = CoreDataManager.giveRealCount(spendingCD: spendingCD)
                
                presenter?.didDeleteTransaction(cellType: .spending,
                                                fromCellRow: from,
                                                fromCellCount: spendingCount,
                                                toCellRow: to,
                                                toCellCount: count)
            } else {
                from = Int(transaction.accountTransaction?.id ?? 0)
                to = Int(transaction.accountDestination?.id ?? 0)
                let count = CoreDataManager.deleteTransaction(identificator: identificator)
                presenter?.didDeleteTransaction(cellType: .account,
                                                fromCellRow: from,
                                                fromCellCount: count,
                                                toCellRow: to,
                                                toCellCount: count)
            }
        }

    }
    
}
