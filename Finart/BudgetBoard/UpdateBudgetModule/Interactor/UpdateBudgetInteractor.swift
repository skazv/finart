//
//  UpdateBudgetInteractor.swift
//  Finart
//
//  Created by Suren Kazaryan on 15.05.2022.
//

import Foundation

class UpdateBudgetInteractor: UpdateBudgetInteractorInputProtocol {
    var presenter: UpdateBudgetInteractorOutputProtocol?
    
    func updateBudget(budgetId: Int, name: String, icon: String?, reportDay: Date, currency: String) {
        let budgets = try? CoreDataManager.fetchBudgets()
        guard let budgets = budgets else { return }
        guard let budget = try? CoreDataManager.updateBudget(budget: budgets[budgetId],
                                                             name: name,
                                                             icon: icon,
                                                             reportDay: reportDay,
                                                             currency: currency) else { return }
        presenter?.didUpdateBudget(budgetCD: budget)
    }
    
    func fetchBudget(budgetId: Int) {
        guard let budgets = try? CoreDataManager.fetchBudgets() else { return }
        presenter?.didFetchBudget(budgetsCD: budgets[budgetId])
    }
    
}
