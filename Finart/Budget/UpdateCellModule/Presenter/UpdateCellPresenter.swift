//
//  UpdateCellPresenter.swift
//  Finart
//
//  Created by Suren Kazaryan on 28.04.2022.
//

import Foundation
import UIKit

class UpdateCellPresenter: UpdateCellPresenterProtocol {
    var view: UpdateCellViewProtocol?
    var interactor: UpdateCellInteractorInputProtocol?
    var router: UpdateCellRouterProtocol?
    var delegate: UpdateCellDelegate?
    var budgetId: Int?
    var cellType: CellType?
    var cellRow: Int?
    
    func updateCell(name: String, count: Int, icon: String?) {
        guard let cellType = cellType else { return }
        guard let cellRow = cellRow else { return }
        guard let budgetId = budgetId else { return }
        
        if let view = view {
            interactor?.updateCell(budgetId: budgetId, cellType: cellType, cellRow: cellRow, name: name, count: count, icon: icon)
            router?.dismissUpdateCell(from: view, completion: nil) // Use complition
        }
        
    }
    
    func viewDidLoad() {
        guard let cellType = cellType else { return }
        guard let cellRow = cellRow else { return }
        guard let budgetId = budgetId else { return }
        
        interactor?.fetchCell(budgetId: budgetId, cellType: cellType, row: cellRow)
    }
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissUpdateCell(from: view, completion: nil)
    }
    
    func chooseIcon() {
        guard let view = view else { return }
        router?.presentIconsScreen(from: view)
    }
    
}

//MARK: - UpdateCellInteractorOutputProtocol
extension UpdateCellPresenter: UpdateCellInteractorOutputProtocol {
    
    func didFetchIncome(income: IncomeCD) {
        guard let name = income.name else { return }
        guard let icon = income.icon else { return }
        guard let image = UIImage(systemName: icon) else { return }
        guard let currency = income.currency else { return }
        //CoreData УЖСАТНОАВАФЫВ
        let count = CoreDataManager.giveRealCount(incomeCD: income)
        
        let viewModel = IncomeViewModel(name: name, count: count, planCount: Int(income.planCount), icon: image, currency: currency)
        view?.reloadIncome(with: viewModel)
    }
    
    func didFetchAccount(account: AccountCD) {
        guard let name = account.name else { return }
        guard let icon = account.icon else { return }
        guard let image = UIImage(systemName: icon) else { return }
        guard let currency = account.currency else { return }
        
        let viewModel = AccountViewModel(name: name, count: Int(account.count), icon: image, currency: currency)
        view?.reloadAccount(with: viewModel)
    }
    
    func didFetchSpending(spending: SpendingCD) {
        guard let name = spending.name else { return }
        guard let icon = spending.icon else { return }
        guard let image = UIImage(systemName: icon) else { return }
        guard let currency = spending.currency else { return }
        //CoreData УЖСАТНОАВАФЫВ
        let count = CoreDataManager.giveRealCount(spendingCD: spending)
        
        let viewModel = SpendingViewModel(name: name, count: count, planCount: Int(spending.planCount), icon: image, currency: currency)
        view?.reloadSpending(with: viewModel)
    }
    
    func didUpdateCell(cellType: CellType, incomeCD: IncomeCD?, accountCD: AccountCD?, spendingCD: SpendingCD?) {
        delegate?.didUpdateCell(cellType: cellType, incomeCD: incomeCD, accountCD: accountCD, spendingCD: spendingCD)
    }
    
    
    func didUpdateCell(cellType: CellType, cellRow: Int, name: String, count: Int, icon: String) {
        //delegate?.didUpdateCell(cellType: cellType, cellRow: cellRow, name: name, count: count, icon: icon)
        
    }
    
}

//MARK: - IconsDelegate
extension UpdateCellPresenter: IconsDelegate {
    func didChooseIcon(iconName: String) {
        view?.didChooseImage(iconName: iconName)
    }
    
}
