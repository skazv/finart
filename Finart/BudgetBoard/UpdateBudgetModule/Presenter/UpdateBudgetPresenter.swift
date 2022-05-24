//
//  UpdateBudgetPresenter.swift
//  Finart
//
//  Created by Suren Kazaryan on 15.05.2022.
//

import Foundation

class UpdateBudgetPresenter: UpdateBudgetPresenterProtocol {
    var view: UpdateBudgetViewProtocol?
    var interactor: UpdateBudgetInteractorInputProtocol?
    var router: UpdateBudgetRouterProtocol?
    var delegate: UpdateBudgetDelegate?
    var budgetId: Int?

    func viewDidLoad() {
        guard let budgetId = budgetId else { return }
        interactor?.fetchBudget(budgetId: budgetId)
    }
    
    func updateBudget(name: String, icon: String?, reportDay: Date, currency: String) {
        guard let budgetId = budgetId else { return }
        interactor?.updateBudget(budgetId: budgetId, name: name, icon: icon, reportDay: reportDay, currency: currency)
    }
    
    func chooseIcon() {
        guard let view = view else { return }
        router?.presentIconsScreen(from: view)
    }
    
    func chooseCurrency() {
        guard let view = view else { return }
        router?.presentCurrencyScreen(from: view)
    }
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissUpdateBudget(from: view, completion: nil)
    }
    
}

//MARK: - UpdateBudgetInteractorOutputProtocol
extension UpdateBudgetPresenter: UpdateBudgetInteractorOutputProtocol {
    func didFetchBudget(budgetsCD: BudgetCD) {
        view?.didFetchBudget(budget: budgetCDtobudgetVM(budgetCD: budgetsCD))

    }
    
    func didUpdateBudget(budgetCD: BudgetCD) {
        delegate?.didUpdateBudget(budgetCD: budgetCD)
    }
    
    
}

//MARK: - IconsDelegate
extension UpdateBudgetPresenter: IconsDelegate {
    func didChooseIcon(iconName: String) {
        view?.didChooseImage(iconName: iconName)
    }
    
    
}

//MARK: - CurrencyDelegate
extension UpdateBudgetPresenter: CurrencyDelegate {
    func didChooseCurrency(currencyName: String) {
        view?.didChooseCurrency(currencyName: currencyName)
    }
    
}
