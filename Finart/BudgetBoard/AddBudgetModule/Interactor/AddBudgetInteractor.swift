//
//  AddBudgetInteractor.swift
//  Finart
//
//  Created by Suren Kazaryan on 08.05.2022.
//

import Foundation

class AddBudgetInteractor: AddBudgetInteractorInputProtocol {
    var presenter: AddBudgetInteractorOutputProtocol?
    
    func addBudget(name: String, icon: String, reportDate: Date, currency: String) {
        let budget = try? CoreDataManager.createBudget(name: name,
                                         icon: icon,
                                         reportDay: reportDate,
                                         currency: currency)
        guard let budget = budget else { return }
        presenter?.didAddBudget(budgetCD: budget)
    }
    
}
