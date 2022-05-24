//
//  BudgetInteractor.swift
//  Finart
//
//  Created by Suren Kazaryan on 20.04.2022.
//

import Foundation

class BudgetInteractor: BudgetInteractorInputProtocol {
    var presenter: BudgetInteractorOutputProtocol?
    let currencyService = CurrencyService()
    
    func fetchCurrentBudget() {
        let currentBudgetId = UserDefaultsManager.getStartBudget()
        let budgets = try? CoreDataManager.fetchBudgets()
        guard let budgets = budgets else { return }
        presenter?.didFetchCurrentBudget(budgetCD: budgets[currentBudgetId])
    }
    
    func fetchCellsByBudget(budgetId: Int, cellType: CellType) {
        let budgetsCD = try? CoreDataManager.fetchBudgets()
        guard let budgetsCD = budgetsCD else { return }
        let budget = budgetsCD[budgetId]
        
        if checkIsMainFind(budgetsCD: budgetsCD) == false {
            UserDefaultsManager.setStartBudget(id: budgetId)
        }
        
        switch cellType {
        case .income:
            let incomesCD = try? CoreDataManager.fetchIncomesByBudget(budget: budget)
            guard let incomesCD = incomesCD else { return }
            presenter?.didFetchIncomes(incomes: incomesCD)
        case .account:
            let accountsCD = try? CoreDataManager.fetchAccountsByBudget(budget: budget)
            guard let accountsCD = accountsCD else { return }
            presenter?.didFetchAccounts(accounts: accountsCD)
        case .spending:
            let spendingsCD = try? CoreDataManager.fetchSpendingsByBudget(budget: budget)
            guard let spendingsCD = spendingsCD else { return }
            presenter?.didFetchSpendings(spendings: spendingsCD)
        }
        presenter?.didFetchCurrentBudget(budgetCD: budget)
    }
    
    func fetchCells(cellType: CellType) {
        let budgetId = UserDefaultsManager.getStartBudget()
        let budgetsCD = try? CoreDataManager.fetchBudgets()
        guard var budget = budgetsCD?[budgetId] else { return }
        budgetsCD?.forEach({ budgetCD in
            if budgetCD.isMain {
                budget = budgetCD
            }
        })
        switch cellType {
        case .income:
            let incomesCD = try? CoreDataManager.fetchIncomesByBudget(budget: budget)
            guard let incomesCD = incomesCD else { return }
            presenter?.didFetchIncomes(incomes: incomesCD)
        case .account:
            let accountsCD = try? CoreDataManager.fetchAccountsByBudget(budget: budget)
            guard let accountsCD = accountsCD else { return }
            presenter?.didFetchAccounts(accounts: accountsCD)
        case .spending:
            let spendingsCD = try? CoreDataManager.fetchSpendingsByBudget(budget: budget)
            guard let spendingsCD = spendingsCD else { return }
            presenter?.didFetchSpendings(spendings: spendingsCD)
        }
    }
    
    func deleteCell(budgetId: Int, cellType: CellType, row: Int) {
        let budget = getBudget(budgetId: budgetId)

        switch cellType {
        case .income:
            CoreDataManager.deleteIncome(budget: budget, with: row)
            presenter?.didDeleteIncome(row: row)
        case .account:
            CoreDataManager.deleteAccount(budget: budget, with: row)
            presenter?.didDeleteAccount(row: row)
        case .spending:
            CoreDataManager.deleteSpending(budget: budget, with: row)
            presenter?.didDeleteSpending(row: row)
        }
    }
    
    func moveCell(budgetId: Int, cellType: CellType, source: Int, destinashion: Int) {
        let budget = getBudget(budgetId: budgetId)
        
        switch cellType {
        case .income:
            CoreDataManager.moveIncome(budget: budget, source: source, destination: destinashion)
            presenter?.didMoveCell(source: source, destinashion: destinashion)
        case .account:
            CoreDataManager.moveAccount(budget: budget, source: source, destination: destinashion)
            presenter?.didMoveAccountCell(source: source, destinashion: destinashion)
        case .spending:
            CoreDataManager.moveSpending(budget: budget, source: source, destination: destinashion)
            presenter?.didMoveSpendingCell(source: source, destinashion: destinashion)
        }
    }
    
    func fetchCurrencyRates() {
        currencyService.fetchCurrency { [weak self] result in
            switch result {
            case .success(let currencyRawArr):
                self?.presenter?.didFetchCurrencyRates(currencyRaw: currencyRawArr)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

//MARK: - Private methods
extension BudgetInteractor {
    private func checkIsMainFind(budgetsCD: [BudgetCD]) -> Bool {
        var isMain = false
                
        budgetsCD.forEach({ budgetCD in
            if budgetCD.isMain {
                isMain = true
            }
        })
        
        return isMain
    }
    
}
