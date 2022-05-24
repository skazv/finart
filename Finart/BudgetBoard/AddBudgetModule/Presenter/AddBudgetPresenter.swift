//
//  AddBudgetPresenter.swift
//  Finart
//
//  Created by Suren Kazaryan on 08.05.2022.
//

import Foundation

class AddBudgetPresenter: AddBudgetPresenterProtocol {
    var view: AddBudgetViewProtocol?
    var interactor: AddBudgetInteractorInputProtocol?
    var router: AddBudgetRouterProtocol?
    var delegate: AddBudgetDelegate?
    
    func addBudget(name: String, icon: String, reportDay: Date, currency: String) {
        interactor?.addBudget(name: name, icon: icon, reportDate: reportDay, currency: currency)
    }
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissAddBudget(from: view, completion: nil)
    }
    
    func chooseIcon() {
        guard let view = view else { return }
        router?.presentIconsScreen(from: view)
    }
    
    func chooseCurrency() {
        guard let view = view else { return }
        router?.presentCurrencyScreen(from: view)
    }
    
}

//MARK: - AddBudgetInteractorOutputProtocol
extension AddBudgetPresenter: AddBudgetInteractorOutputProtocol {
    func didAddBudget(budgetCD: BudgetCD) {
        delegate?.didAddBudget(budgetCD: budgetCD)
    }
    
}


//MARK: - IconsDelegate
extension AddBudgetPresenter: IconsDelegate {
    func didChooseIcon(iconName: String) {
        view?.didChooseImage(iconName: iconName)
    }
}

//MARK: - CurrencyDelegate
extension AddBudgetPresenter: CurrencyDelegate {
    func didChooseCurrency(currencyName: String) {
        view?.didChooseCurrency(currencyName: currencyName)
    }
    
}

