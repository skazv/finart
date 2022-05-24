//
//  AddCellInteractor.swift
//  Finart
//
//  Created by Suren Kazaryan on 23.04.2022.
//

import Foundation

class AddCellInteractor: AddCellInteractorInputProtocol {
    var presenter: AddCellInteractorOutputProtocol?
    
    func saveCell(budgetId: Int, name: String, count: Int, icon: String, currency: String) -> IncomeCD? {
        let budget = getBudget(budgetId: budgetId)
        let income = try? CoreDataManager.createIncomeByBudget(budget: budget, name: name, count: count, icon: icon, currency: currency)
        return income
    }
    
    func saveAccountCell(budgetId: Int, name: String, count: Int, icon: String, currency: String) -> AccountCD? {
        let budget = getBudget(budgetId: budgetId)
        let account = try? CoreDataManager.createAccountByBudget(budget: budget, name: name, count: count, icon: icon, currency: currency)
        return account
    }
    
    func saveSpendingCell(budgetId: Int, name: String, count: Int, icon: String, currency: String) -> SpendingCD? {
        let budget = getBudget(budgetId: budgetId)
        let spending = try? CoreDataManager.createSpendingByBudget(budget: budget, name: name, count: count, icon: icon, currency: currency)
        return spending
    }
    
}
