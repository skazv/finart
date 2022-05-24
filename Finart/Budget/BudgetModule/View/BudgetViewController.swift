//
//  BudgetViewControlller.swift
//  Finart
//
//  Created by Suren Kazaryan on 20.04.2022.
//

import UIKit

class BudgetViewController: UIViewController {
    let budgetView = BudgetView()
    var presenter: BudgetPresenterProtocol?
    var currentBudgetId: Int?
    var currentBudgetViewModel: BudgetViewModel?
    var reportDay: Date? // Убрать так как вью модель есть
    var source: Int?
    var destination: Int?
    //Нужны такие названия?
    let addCellButton = IncomeViewModel(name: "AddButton20042022", count: 0, planCount: 0, icon: UIImage(systemName: "plus.app") ?? .add, currency: "USD")
    let accountAddButton = AccountViewModel(name: "AddButton20042022", count: 0, icon: UIImage(systemName: "plus.rectangle") ?? .add, currency: "USD")
    let spendingAddButton = SpendingViewModel(name: "AddButton20042022", count: 0, planCount: 0, icon: UIImage(systemName: "plus.app") ?? .add, currency: "USD")
    var currencyRate: CurrencyRaw?
    
    override func loadView() {
        super.loadView()
        view = budgetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaultsManager.firstLoadSettings() == true {
            firstLoad()
        }
        firstLoad()
        presenter?.viewDidLoad()
        budgetView.incomeView.budgetViewDelegate = self
        budgetView.accountView.budgetViewDelegate = self
        budgetView.spendView.budgetViewDelegate = self
        setup()
        updateTopView()
    }
    
}

//MARK: - Private methods
extension BudgetViewController {
    private func setup() {
        budgetView.selectBudgetTableButton.addTarget(self, action: #selector(budgetTapped), for: .touchUpInside)

        navigationItem.titleView = budgetView.selectBudgetTableButton
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(budgetsBoardTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTaped))
        
    }
    
    @objc private func editTaped() {
        if budgetView.incomeView.isEditing {
            budgetView.incomeView.isEditing = false
            budgetView.incomeView.incomeViewModels.append(addCellButton)
            budgetView.incomeView.reloadData()
            
            budgetView.accountView.isEditing = false
            budgetView.accountView.accountArray.append(accountAddButton)
            budgetView.accountView.reloadData()
            
            budgetView.spendView.isEditing = false
            budgetView.spendView.spendingArray.append(spendingAddButton)
            budgetView.spendView.reloadData()
            
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTaped))
        } else {
            budgetView.incomeView.isEditing = true
            budgetView.incomeView.incomeViewModels.removeLast()
            budgetView.incomeView.reloadData()
            
            budgetView.accountView.isEditing = true
            budgetView.accountView.accountArray.removeLast()
            budgetView.accountView.reloadData()
            
            budgetView.spendView.isEditing = true
            budgetView.spendView.spendingArray.removeLast()
            budgetView.spendView.reloadData()
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTaped))
        }
    }
    
    @objc private func budgetTapped() {
        if budgetView.incomeView.isEditing {
            editTaped()
        }
        guard let currentBudgetId = currentBudgetId else { return }
        presenter?.showBudgetsTable(budgetId: currentBudgetId)
    }
    
    @objc private func budgetsBoardTapped() {
        presenter?.showBudgetsBoard()
    }
    
    //DELETE?
    @objc private func addTaped() {
    }
    
    private func updateTopView() {
        guard let currency = currentBudgetViewModel?.currency else { return }
        let symbol = giveCurrencyVM(currency: currency).symbol
        
        budgetView.incomeValueLabel.text = "\(currencyFormat(number: calculateTopView(cellType: .income))) \(symbol)"
        budgetView.spendingValuewLabel.text = "\(currencyFormat(number: calculateTopView(cellType: .spending))) \(symbol)"
        budgetView.accountValueLabel.text = "\(currencyFormat(number: calculateTopView(cellType: .account))) \(symbol)"
        budgetView.incomePlanLabel.text = "\(currencyFormat(number: calculateTopViewPlan(cellType: .income)))"
        budgetView.spendingPlanLabel.text = "\(currencyFormat(number: calculateTopViewPlan(cellType: .spending)))"
        budgetView.accountPlanLabel.text = "\(currencyFormat(number: calculateTopViewPlan(cellType: .account)))"
    }
    
    private func calculateTopView(cellType: CellType) -> Int {
        var result = 0
        guard let mainCurrency = currentBudgetViewModel?.currency else { return 0 }
        
        switch cellType {
        case .income:
            budgetView.incomeView.incomeViewModels.forEach { incomeModel in
                if incomeModel.currency == currentBudgetViewModel?.currency {
                    result += incomeModel.count
                } else {
                    result += incomeBalanceByCurrency(mainCurrency: mainCurrency, incomeViewModel: incomeModel, currencyRaw: CurrencyRaw(AMD: 1, USD: 1, EUR: 1, RUB: 1))
                }
            }
        case .account:
            budgetView.accountView.accountArray.forEach { accountModel in
                result += accountModel.count
            }
        case .spending:
            budgetView.spendView.spendingArray.forEach { spendingModel in
                result += spendingModel.count
            }
        }
        return result
    }
    
    private func calculateTopViewPlan(cellType: CellType) -> Int {
        var result = 0
        
        switch cellType {
        case .income:
            budgetView.incomeView.incomeViewModels.forEach { incomeModel in
                result += incomeModel.planCount
            }
        case .account:
            var income = 0
            var spending = 0
            
            budgetView.incomeView.incomeViewModels.forEach { incomeModel in
                income += incomeModel.count
            }
            budgetView.spendView.spendingArray.forEach { spendingModel in
                spending += spendingModel.count
            }
            result = income - spending
        case .spending:
            budgetView.spendView.spendingArray.forEach { spendingModel in
                result += spendingModel.planCount
            }
        }
        return result
    }
    
    private func firstLoad() {
        let onboarding = OnboardingViewController()
        guard let budget = try? CoreDataManager.createBudget(name: "Личный бюджет",
                                                             icon: IconLib.house.rawValue,
                                                             reportDay: giveAppCreatingDate(),
                                                             currency: "RUB") else { return }
        guard let income = try? CoreDataManager.createIncomeByBudget(budget: budget,
                                                                     name: "Зарплата",
                                                                     count: 40000,
                                                                     icon: IconLib.briefcase.rawValue,
                                                                     currency: "RUB") else { return }
        guard let cardAccount = try? CoreDataManager.createAccountByBudget(budget: budget,
                                                                     name: "Карта",
                                                                     count: 0,
                                                                       icon: IconLib.creditCard.rawValue,
                                                                           currency: "RUB") else { return }
        guard let cashAccount = try? CoreDataManager.createAccountByBudget(budget: budget,
                                                                     name: "Наличные",
                                                                     count: 0,
                                                                           icon: IconLib.banknote.rawValue,
                                                                           currency: "RUB") else { return }

        guard let transportSpending = try? CoreDataManager.createSpendingByBudget(budget: budget,
                                                                     name: "Транспорт",
                                                                     count: 3000,
                                                                         icon: IconLib.bus.rawValue,
                                                                                  currency: "RUB") else { return }
        guard let foodSpending = try? CoreDataManager.createSpendingByBudget(budget: budget,
                                                                     name: "Еда",
                                                                     count: 8000,
                                                                             icon: IconLib.forkKnife.rawValue,
                                                                             currency: "RUB") else { return }
        guard let shoppingSpending = try? CoreDataManager.createSpendingByBudget(budget: budget,
                                                                     name: "Покупки",
                                                                     count: 10000,
                                                                             icon: IconLib.cart.rawValue,
                                                                                 currency: "RUB") else { return }


        reloadIncomeView(with: [incomeCDtoIncomeVM(incomeCD: income)])
        reloadAccountView(with: [accountCDtoAccountVM(accountCD: cardAccount),
                                 accountCDtoAccountVM(accountCD: cashAccount),])
        reloadSpendingView(with: [spendingCDtoSpendingVM(spendingCD: transportSpending),
                                  spendingCDtoSpendingVM(spendingCD: foodSpending),
                                  spendingCDtoSpendingVM(spendingCD: shoppingSpending),
        ])
        
        navigationController?.present(onboarding, animated: true)
    }
    
}

//MARK: - BudgetViewProtocol
extension BudgetViewController: BudgetViewProtocol {
    func didFetchCurrencyRates(currencyRaw: CurrencyRaw) {
        currencyRate = currencyRaw
    }
    
    func didFetchCurrentBudget(budgetViewModel: BudgetViewModel) {
        budgetView.update(budgetName: budgetViewModel.name)
        currentBudgetId = UserDefaultsManager.getStartBudget()
        currentBudgetViewModel = budgetViewModel
        reportDay = budgetViewModel.reportDay // УБРАТЬ
        updateTopView()
    }
    
    func didAddBudget(budget: BudgetViewModel) {
        budgetView.update(budgetName: budget.name)
    }
    
    func didClosedTransaction() {
        budgetView.accountView.reloadData()
    }
    
    func didTransactionCell(cellType: CellType, fromCellRow: Int, fromCellCount: Int, toCellRow: Int, toCellCount: Int) {
        switch cellType {
        case .income:
            budgetView.incomeView.incomeViewModels[fromCellRow].count = fromCellCount
            budgetView.incomeView.reloadData()

            budgetView.accountView.accountArray[toCellRow].count += toCellCount
            budgetView.accountView.reloadData()
        case .account:
            budgetView.accountView.accountArray[fromCellRow].count -= fromCellCount
            budgetView.accountView.accountArray[toCellRow].count += toCellCount
            budgetView.accountView.reloadData()
        case .spending:
            budgetView.accountView.accountArray[fromCellRow].count -= fromCellCount
            budgetView.accountView.reloadData()
            
            budgetView.spendView.spendingArray[toCellRow].count = toCellCount
            budgetView.spendView.reloadData()
        }
        updateTopView()
    }
    
    func didUpdateCell(cellType: CellType, cellRow: Int, income: IncomeViewModel?, account: AccountViewModel?, spending: SpendingViewModel?) {
        switch cellType {
        case .income:
            guard let income = income else { return }
            budgetView.incomeView.incomeViewModels[cellRow] = income
            budgetView.incomeView.reloadData()
        case .account:
            guard let account = account else { return }
            budgetView.accountView.accountArray[cellRow] = account
            budgetView.accountView.reloadData()
        case .spending:
            guard let spending = spending else { return }
            budgetView.spendView.spendingArray[cellRow] = spending
            budgetView.spendView.reloadData()
        }
        updateTopView()
    }
    
    func didMoveCell(source: Int, destinashion: Int) {
        let item =  budgetView.incomeView.incomeViewModels.remove(at: source)
        budgetView.incomeView.incomeViewModels.insert(item, at: destinashion)
    }
    
    func didMoveAccountCell(source: Int, destinashion: Int) {
        let item = budgetView.accountView.accountArray.remove(at: source)
        budgetView.accountView.accountArray.insert(item, at: destinashion)
    }
    
    func didMoveSpendingCell(source: Int, destinashion: Int) {
        let item = budgetView.spendView.spendingArray.remove(at: source)
        budgetView.spendView.spendingArray.insert(item, at: destinashion)
    }
    
    func reloadIncomeView(with incomeViewModels: [IncomeViewModel]) {
        budgetView.incomeView.incomeViewModels = incomeViewModels
        budgetView.incomeView.incomeViewModels.append(addCellButton)
        budgetView.incomeView.reloadData()
    }
    
    func reloadAccountView(with accountViewModels: [AccountViewModel]) {
        budgetView.accountView.accountArray = accountViewModels
        budgetView.accountView.accountArray.append(accountAddButton)
        budgetView.accountView.reloadData()
    }
    
    func reloadSpendingView(with spendingViewModels: [SpendingViewModel]) {
        budgetView.spendView.spendingArray = spendingViewModels
        budgetView.spendView.spendingArray.append(spendingAddButton)
        budgetView.spendView.reloadData()
    }

    func didAddIncome(incomeViewModel: IncomeViewModel) {
        let count =  budgetView.incomeView.incomeViewModels.count
        budgetView.incomeView.incomeViewModels.insert(incomeViewModel, at: count - 1)
        
        let insertedindexPath = IndexPath(item: count - 1, section: 0)
        budgetView.incomeView.insertItems(at: [insertedindexPath])
        updateTopView()
    }
    
    func didAddAccount(accountViewModel: AccountViewModel) {
        let count =  budgetView.accountView.accountArray.count
        budgetView.accountView.accountArray.insert(accountViewModel, at: count - 1)
        
        let insertedindexPath = IndexPath(item: count - 1, section: 0)
        budgetView.accountView.insertItems(at: [insertedindexPath])
    }
    
    func didAddSpending(spendingViewModel: SpendingViewModel) {
        let count =  budgetView.spendView.spendingArray.count
        budgetView.spendView.spendingArray.insert(spendingViewModel, at: count - 1)
        
        let insertedindexPath = IndexPath(item: count - 1, section: 0)
        budgetView.spendView.insertItems(at: [insertedindexPath])
        updateTopView()
    }
    
    //MARK: - DON' T DELETE
    func didDeleteIncome(row: Int) {
    }
    //MARK: - DON' T DELETE
    
    //MARK: - DON' T DELETE
    func didDeleteAccount(row: Int) {
    }
    //MARK: - DON' T DELETE
    
    //MARK: - DON' T DELETE
    func didDeleteSpending(row: Int) {
    }
    //MARK: - DON' T DELETE
    
    func didDeleteTransaction(cellType: CellType, fromCellRow: Int, fromCellCount: Int, toCellRow: Int, toCellCount: Int) {
        switch cellType {
        case .income:
            budgetView.incomeView.incomeViewModels[fromCellRow].count = fromCellCount
            budgetView.incomeView.reloadData()

            budgetView.accountView.accountArray[toCellRow].count -= toCellCount
            budgetView.accountView.reloadData()
        case .account:
            budgetView.accountView.accountArray[fromCellRow].count += fromCellCount
            budgetView.accountView.accountArray[toCellRow].count -= toCellCount
            budgetView.accountView.reloadData()
        case .spending:
            budgetView.accountView.accountArray[toCellRow].count += toCellCount
            budgetView.accountView.reloadData()
            
            budgetView.spendView.spendingArray[fromCellRow].count = fromCellCount
            budgetView.spendView.reloadData()
        }
        updateTopView()
    }
    
}

//MARK: - BudgetViewProtocol
extension BudgetViewController: BudgetViewDelegate {
    
    func addCell(cellType: CellType) {
        guard let budgetId = currentBudgetId else { return }
        guard let currentBudgetVM = currentBudgetViewModel else { return }
        presenter?.addCell(from: self, budgetId: budgetId, cellType: cellType, currency: currentBudgetVM.currency)
    }
    
    func deleteCell(cellType: CellType, row: Int) {
        guard let budgetId = currentBudgetId else { return }
        presenter?.deleteCell(budgetId: budgetId, cellType: cellType, row: row)
    }
    
    func moveCell(cellType: CellType, source: Int, destination: Int) {
        guard let budgetId = currentBudgetId else { return }
        presenter?.moveCell(budgetId: budgetId, cellType: cellType, source: source, destinashion: destination)
    }
    
    func select(cellType: CellType, row: Int) {
        guard let budgetId = currentBudgetId else { return }

        presenter?.showCell(from: self, budgetId: budgetId, cellType: cellType, row: row)
    }
    
    func transaction(fromCellType: CellType, destinationRow: Int) {
        guard let budgetId = currentBudgetId else { return }

        switch fromCellType {
        case .income:
            guard let source = budgetView.incomeView.incomeSourceRow else { return }
            if isSameCurrency(budgetId: budgetId, cellType: .income, from: source, to: destinationRow) {
                presenter?.makeTransaction(from: self, budgetId: budgetId, toCellType: .income, fromCell: source, toCell: destinationRow)
            } else {
                presenter?.makeCurrencyTransaction(from: self, budgetId: budgetId, toCellType: .income, fromCell: source, toCell: destinationRow)
            }
        case .account:
            guard let source = budgetView.accountView.accountSourceRow else { return }
            if isSameCurrency(budgetId: budgetId, cellType: .account, from: source, to: destinationRow) {
                presenter?.makeTransaction(from: self, budgetId: budgetId, toCellType: .account, fromCell: source, toCell: destinationRow)
            } else {
                presenter?.makeCurrencyTransaction(from: self, budgetId: budgetId, toCellType: .account, fromCell: source, toCell: destinationRow)
            }
            budgetView.accountView.accountSourceRow = nil
            budgetView.accountView.accountDestinationRow = nil
        case .spending:
            guard let source = budgetView.accountView.accountSourceRow else { return }
            if isSameCurrency(budgetId: budgetId, cellType: .spending, from: source, to: destinationRow) {
                presenter?.makeTransaction(from: self, budgetId: budgetId, toCellType: .spending, fromCell: source, toCell: destinationRow)
            } else {
                presenter?.makeCurrencyTransaction(from: self, budgetId: budgetId, toCellType: .spending, fromCell: source, toCell: destinationRow)
            }
        }
    }
    
}
