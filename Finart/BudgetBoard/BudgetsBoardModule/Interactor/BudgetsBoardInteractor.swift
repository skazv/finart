//
//  BudgetsBoardInteractor.swift
//  Finart
//
//  Created by Suren Kazaryan on 08.05.2022.
//

import Foundation

class BudgetsBoardInteractor: BudgetsBoardInteractorInputProtocol {
    var presenter: BudgetsBoardInteractorOutputProtocol?
    
    func fetchBudgets() {
        guard let budgetsCD = try? CoreDataManager.fetchBudgets() else { return }
        presenter?.didFetchBudgets(budgetsCD: budgetsCD)
    }
}
