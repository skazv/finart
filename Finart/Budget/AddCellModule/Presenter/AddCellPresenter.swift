//
//  addCellPresenter.swift
//  Finart
//
//  Created by Suren Kazaryan on 23.04.2022.
//

import Foundation

class AddCellPresenter: AddCellPresenterProtocol {
    var view: AddCellViewProtocol?
    var interactor: AddCellInteractorInputProtocol?
    var router: AddCellRouterProtocol?
    var delegate: AddCellDelegate?
    var budgetId: Int?
    var cellType: CellType?
    var currency: String?
    
    func addCell(name: String, count: Int, icon: String, currency: String) {
        guard let cellType = cellType else { return }
        guard let budgetId = budgetId else { return }

        switch cellType {
        case .income:
            let income = interactor?.saveCell(budgetId: budgetId, name: name, count: count, icon: icon, currency: currency)
            if let view = view, let income = income {
                didSaveCell(incomeCD: income)
                router?.dismissAddCell(from: view, completion: nil) // Use complition
            }
        case .account:
            let account = interactor?.saveAccountCell(budgetId: budgetId, name: name, count: count, icon: icon, currency: currency)
            if let view = view, let account = account {
                didSaveAccountCell(accountCD: account)
                router?.dismissAddCell(from: view, completion: nil) // Use complition
            }
        case .spending:
            let spending = interactor?.saveSpendingCell(budgetId: budgetId, name: name, count: count, icon: icon, currency: currency)
            if let view = view, let spending = spending {
                didSaveSpendingCell(spendingCD: spending)
                router?.dismissAddCell(from: view, completion: nil) // Use complition
            }
        }

    }
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissAddCell(from: view, completion: nil)
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

//MARK: - AddCellInteractorOutputProtocol
extension AddCellPresenter: AddCellInteractorOutputProtocol {
    func didSaveSpendingCell(spendingCD: SpendingCD) {
        delegate?.didSaveSpendingCell(spendingCD: spendingCD)
    }
    
    
    func didSaveAccountCell(accountCD: AccountCD) {
        delegate?.didAddAccountCell(accountCD: accountCD)
    }
    
    func didSaveCell(incomeCD: IncomeCD) {
        delegate?.didAddCell(incomeCD: incomeCD)
    }
    
}

//MARK: - IconsDelegate
extension AddCellPresenter: IconsDelegate {
    func didChooseIcon(iconName: String) {
        view?.didChooseImage(iconName: iconName)
    }
}

//MARK: - CurrencyDelegate
extension AddCellPresenter: CurrencyDelegate {
    func didChooseCurrency(currencyName: String) {
        view?.didChooseCurrency(currencyName: currencyName)
    }
    
}
