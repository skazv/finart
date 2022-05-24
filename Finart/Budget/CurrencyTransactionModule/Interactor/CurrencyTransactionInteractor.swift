//
//  CurrencyTransactionInteractor.swift
//  Finart
//
//  Created by Suren Kazaryan on 19.05.2022.
//

import Foundation

class CurrencyTransactionInteractor: CurrencyTransactionInteractorInputProtocol {
    var presenter: CurrencyTransactionInteractorOutputProtocol?
    
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
    
    func saveTransaction(budgetId: Int, toCellType: CellType, fromCell: Int, toCell: Int, name: String, count: Int, secondCount: Int, date: Date) {
        let budget = getBudget(budgetId: budgetId)
        switch toCellType {
        case .income:
            let incomesCD = try? CoreDataManager.fetchIncomesByBudget(budget: budget)
            guard let incomesCD = incomesCD else { return }
            let accountsCD = try? CoreDataManager.fetchAccountsByBudget(budget: budget)
            guard let accountsCD = accountsCD else { return }
            
            let newAccountCount = Int(accountsCD[toCell].count) + secondCount
            try? CoreDataManager.updateAccount(budget: budget, row: toCell, name: nil, count: newAccountCount, icon: nil)
            
           try? CoreDataManager.createTransaction(income: incomesCD[fromCell],
                                                  account: accountsCD[toCell],
                                                  name: name,
                                                  count: count,
                                                  secondCount: secondCount,
                                                  date: date)
            
            let incomeCount = CoreDataManager.giveRealCount(incomeCD: incomesCD[fromCell])
            
            presenter?.didSaveTransaction(cellType: .income,
                                          fromCellRow: fromCell,
                                          fromCellCount: incomeCount,
                                          toCellRow: toCell,
                                          toCellCount: secondCount)
        case .account:
            let accountsCD = try? CoreDataManager.fetchAccountsByBudget(budget: budget)
            guard let accountsCD = accountsCD else { return }
            
            let newFromAccountCount = Int(accountsCD[fromCell].count) - count
            try? CoreDataManager.updateAccount(budget: budget, row: fromCell, name: nil, count: newFromAccountCount, icon: nil)
            
            let newToAccountCount = Int(accountsCD[toCell].count) + secondCount
            try? CoreDataManager.updateAccount(budget: budget, row: toCell, name: nil, count: newToAccountCount, icon: nil)
            
            try? CoreDataManager.createTransaction(accountSource: accountsCD[fromCell],
                                                   accountDestination: accountsCD[toCell],
                                                   name: name,
                                                   count: count,
                                                   secondCount: secondCount,
                                                   date: date)

            presenter?.didSaveTransaction(cellType: .account,
                                          fromCellRow: fromCell,
                                          fromCellCount: count,
                                          toCellRow: toCell,
                                          toCellCount: secondCount)
            
        case .spending:
            let accountsCD = try? CoreDataManager.fetchAccountsByBudget(budget: budget)
            guard let accountsCD = accountsCD else { return }
            let spendingsCD = try? CoreDataManager.fetchSpendingsByBudget(budget: budget)
            guard let spendingsCD = spendingsCD else { return }
            
            let newAccountCount = Int(accountsCD[fromCell].count) - count
            try? CoreDataManager.updateAccount(budget: budget, row: fromCell, name: nil, count: newAccountCount, icon: nil)

            try? CoreDataManager.createTransaction(account: accountsCD[fromCell],
                                                   spending: spendingsCD[toCell],
                                                   name: name,
                                                   count: count,
                                                   secondCount: secondCount,
                                                   date: date)
            
            let spendingCount = CoreDataManager.giveRealCount(spendingCD: spendingsCD[toCell])

            
            presenter?.didSaveTransaction(cellType: .spending,
                                          fromCellRow: fromCell,
                                          fromCellCount: count,
                                          toCellRow: toCell,
                                          toCellCount: spendingCount)
        }
    }
    
}
