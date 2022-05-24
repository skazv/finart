//
//  UpdateCellInteractor.swift
//  Finart
//
//  Created by Suren Kazaryan on 28.04.2022.
//

import Foundation

class UpdateCellInteractor: UpdateCellInteractorInputProtocol {
    var presenter: UpdateCellInteractorOutputProtocol?
    
    func updateCell(budgetId: Int, cellType: CellType, cellRow: Int, name: String, count: Int, icon: String?) {
        let budget = getBudget(budgetId: budgetId)
        
        switch cellType {
        case .income:
            guard let incomeCD = try? CoreDataManager.updateIncome(budget: budget, row: cellRow, name: name, count: count, icon: icon) else { return }
     //       guard let icon = incomeCD.icon else { return }
           // presenter?.didUpdateCell(cellType: cellType, cellRow: cellRow, name: name, count: count, icon: icon)
            presenter?.didUpdateCell(cellType: cellType, incomeCD: incomeCD, accountCD: nil, spendingCD: nil)
        case .account:
            guard let accountCD = try? CoreDataManager.updateAccount(budget: budget, row: cellRow, name: name, count: count, icon: icon) else { return }
       //     guard let icon = accountCD.icon else { return }
            //presenter?.didUpdateCell(cellType: cellType, cellRow: cellRow, name: name, count: count, icon: icon)
            presenter?.didUpdateCell(cellType: cellType, incomeCD: nil, accountCD: accountCD, spendingCD: nil)
        case .spending:
            guard let spendingCD = try? CoreDataManager.updateSpending(budget: budget, row: cellRow, name: name, count: count, icon: icon) else { return }
         //   guard let icon = spendingCD.icon else { return }
            presenter?.didUpdateCell(cellType: cellType, incomeCD: nil, accountCD: nil, spendingCD: spendingCD)
            //presenter?.didUpdateCell(cellType: cellType, cellRow: cellRow, name: name, count: count, icon: icon)
        }
    }
    
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
    
}
