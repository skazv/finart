//
//  BudgetTablesPresenter.swift
//  Finart
//
//  Created by Suren Kazaryan on 05.05.2022.
//

import Foundation
import UIKit

class BudgetTablesPresenter: BudgetTablesPresenterProtocol {
    var view: BudgetTablesViewProtocol?
    var interactor: BudgetTablesInteractorInputProtocol?
    var router: BudgetTablesRouterProtocol?
    var delegate: BudgetTablesDelegate?
    var budgetId: Int?

    func closeViewAndOpenAddBudget() {
        guard let view = view else { return }
        router?.dismissBudgetTables(from: view, completion: nil)
        delegate?.openAddBudget()
    }
    
    func viewDidLoad() {
        interactor?.fetchBudgets()
    }
    
    func chooseBudget(id: Int) {
        guard let view = view else { return }
        router?.dismissBudgetTables(from: view, completion: nil)
        delegate?.reloadAllItems(budgetId: id)
    }
    
    func deleteBudget(with row: Int) {
        interactor?.deleteBudget(with: row)
    }
    
    func closeViewAndOpenUpdateBudget(budgetId: Int) {
        guard let view = view else { return }
        router?.dismissBudgetTables(from: view, completion: nil)
        delegate?.openUpdateBudget(budgetId: budgetId)
    }
    
}

//MARK: - BudgetTablesInteractorOutputProtocol
extension BudgetTablesPresenter: BudgetTablesInteractorOutputProtocol {
    func didFetchBudgets(budgetsCD: [BudgetCD]) {
        var budgetViewModels: [BudgetViewModel]
        
        budgetViewModels = budgetsCD.map { budgetCD in
//            if let name = budgetCD.name {
//                if let icon = budgetCD.icon {
//                    if let image = UIImage(systemName: icon) {
//                        return BudgetViewModel(name: name,
//                                               icon: image,
//                                               reportDay: budgetCD.reportDate ?? Date(), currency: )
//                    }
//                }
//            }
            return budgetCDtobudgetVM(budgetCD: budgetCD)//BudgetViewModel(name: "Empty", icon: .checkmark, reportDay: Date())
        }
        view?.didFetchBudgets(budget: budgetViewModels)
    }
    
    
    func didDeleteBudget(with row: Int) {
        view?.didDeleteBudget(with: row)
    }
    
}

//MARK: - AddBudgetDelegate
extension BudgetTablesPresenter: AddBudgetDelegate {
    func didAddBudget(budgetCD: BudgetCD) {
        guard let name = budgetCD.name else { return }
        guard let icon = budgetCD.icon else { return }
        guard let image = UIImage(systemName: icon) else { return }
        guard let reportDay = budgetCD.reportDate else { return }
        guard let currency = budgetCD.currency else { return }
        
        view?.didAddBudget(budget: BudgetViewModel(name: name, icon: image, reportDay: reportDay, currency: currency))
    }
    
}

////MARK: - UpdateBudgetDelegate
//extension BudgetTablesPresenter: UpdateBudgetDelegate {
//    func didUpdateBudget(budgetCD: BudgetCD) {
//        print("Not supported")
//    }
//
//
//}
