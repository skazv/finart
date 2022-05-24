//
//  BudgetTablesInteractor.swift
//  Finart
//
//  Created by Suren Kazaryan on 05.05.2022.
//

import Foundation

class BudgetTablesInteractor: BudgetTablesInteractorInputProtocol {
    var presenter: BudgetTablesInteractorOutputProtocol?
    
    func fetchBudgets() {
        let budgetsCD = try? CoreDataManager.fetchBudgets()
        guard let budgetsCD = budgetsCD else { return }
        presenter?.didFetchBudgets(budgetsCD: budgetsCD)
    }
    
    func deleteBudget(with row: Int) {
        CoreDataManager.deleteBudget(with: row)
        presenter?.didDeleteBudget(with: row)
    }
    
}
