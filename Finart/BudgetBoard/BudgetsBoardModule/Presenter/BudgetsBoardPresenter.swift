//
//  BudgetsBoardPresenter.swift
//  Finart
//
//  Created by Suren Kazaryan on 08.05.2022.
//

import Foundation

class BudgetsBoardPresenter: BudgetsBoardPresenterProtocol {
    var view: BudgetsBoardViewProtocol?
    var interactor: BudgetsBoardInteractorInputProtocol?
    var router: BudgetsBoardRouterProtocol?
    var delegate: BudgetsBoardDelegate?
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissBudgetsBoard(from: view, completion: nil)
    }
    
    func viewDidLoad() {
        interactor?.fetchBudgets()
    }
    
}

//MARK: - BudgetsBoardInteractorOutputProtocol
extension BudgetsBoardPresenter: BudgetsBoardInteractorOutputProtocol {
    func didFetchBudgets(budgetsCD: [BudgetCD]) {
        let budgets: [BudgetViewModel] = budgetsCD.map { budgetCD in
            return budgetCDtobudgetVM(budgetCD: budgetCD)
        }
        view?.didFetchBudgets(budgets: budgets)
    }
    
    
}

