//
//  CurrencyTransactionPresenter.swift
//  Finart
//
//  Created by Suren Kazaryan on 19.05.2022.
//

import Foundation
import UIKit

class CurrencyTransactionPresenter: CurrencyTransactionPresenterProtocol {
    var view: CurrencyTransactionViewProtocol?
    var interactor: CurrencyTransactionInteractorInputProtocol?
    var router: CurrencyTransactionRouterProtocol?
    var delegate: CurrencyTransactionDelegate?
    var budgetId: Int?
    var fromCell: Int?
    var toCell: Int?
    var toCellType: CellType?
    
    func viewDidLoad() {
        guard let toCellType = toCellType else { return }
        switch toCellType {
        case .income:
            guard let fromCell = fromCell else { return }
            guard let toCell = toCell else { return }
            guard let budgetId = budgetId else { return }
            
            interactor?.fetchCell(budgetId: budgetId, cellType: .income, row: fromCell)
            interactor?.fetchCell(budgetId: budgetId, cellType: .account, row: toCell)
        case .account:
            guard let fromCell = fromCell else { return }
            guard let toCell = toCell else { return }
            guard let budgetId = budgetId else { return }
            
            interactor?.fetchCell(budgetId: budgetId, cellType: .account, row: fromCell)
            interactor?.fetchCell(budgetId: budgetId, cellType: .account, row: toCell)
        case .spending:
            guard let fromCell = fromCell else { return }
            guard let toCell = toCell else { return }
            guard let budgetId = budgetId else { return }
            
            interactor?.fetchCell(budgetId: budgetId, cellType: .account, row: fromCell)
            interactor?.fetchCell(budgetId: budgetId, cellType: .spending, row: toCell)
            
        }
    }
    
    func addTransaction(fromCell: Int, toCell: Int, name: String, count: Int, secondCount: Int, date: Date) {
        guard let toCellType = toCellType else { return }
        guard let budgetId = budgetId else { return }
        
        interactor?.saveTransaction(budgetId: budgetId,
                                    toCellType: toCellType,
                                    fromCell: fromCell,
                                    toCell: toCell,
                                    name: name,
                                    count: count,
                                    secondCount: secondCount,
                                    date: date)
        
        if let view = view {
            router?.dismissCurrencyTransaction(from: view, completion: nil) //USE completion
        }
    }
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissCurrencyTransaction(from: view, completion: nil)
    }
    
}

//MARK: - CurrencyTransactionInteractorOutputProtocol
extension CurrencyTransactionPresenter: CurrencyTransactionInteractorOutputProtocol {
    func didSaveTransaction(cellType: CellType, fromCellRow: Int, fromCellCount: Int, toCellRow: Int, toCellCount: Int) {
        delegate?.didSaveCurrencyTransaction(cellType: cellType, fromCellRow: fromCellRow, fromCellCount: fromCellCount, toCellRow: toCellRow, toCellCount: toCellCount)
    }
    
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
    
    
}

