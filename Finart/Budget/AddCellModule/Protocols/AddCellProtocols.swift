//
//  AddIncomeProtocols.swift
//  Finart
//
//  Created by Suren Kazaryan on 23.04.2022.
//

import UIKit

protocol AddCellDelegate: AnyObject {
    func didAddCell(incomeCD: IncomeCD)
    func didAddAccountCell(accountCD: AccountCD)
    func didSaveSpendingCell(spendingCD: SpendingCD)
}

protocol AddCellViewProtocol: AnyObject {
    var presenter: AddCellPresenterProtocol? { get set }
    var iconName: String? { get set }
    var currencyName: String? { get set }
    
    // PRESENTER -> VIEW
    func didChooseImage(iconName: String)
    func didChooseCurrency(currencyName: String)
}

protocol AddCellPresenterProtocol: AnyObject {
    var view: AddCellViewProtocol? { get set }
    var interactor: AddCellInteractorInputProtocol? { get set }
    var router: AddCellRouterProtocol? { get set }
    var delegate: AddCellDelegate? { get set }
    var budgetId: Int? { get set }
    var cellType: CellType? { get set }
    var currency: String? { get set }
    
    // VIEW -> PRESENTER
    func addCell(name: String, count: Int, icon: String, currency: String)
    func closeView()
    func chooseCurrency()
    func chooseIcon()
}

protocol AddCellRouterProtocol: AnyObject {
    static func createAddCellModul(with delegate: AddCellDelegate, budgetId: Int, cellType: CellType, currency: String) -> UIViewController
    
    // PRESENTER -> ROUTER
    func dismissAddCell(from view: AddCellViewProtocol, completion: (() -> Void)?)
    func presentIconsScreen(from view: AddCellViewProtocol)
    func presentCurrencyScreen(from view: AddCellViewProtocol)
}

protocol AddCellInteractorInputProtocol: AnyObject {
    var presenter: AddCellInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func saveCell(budgetId: Int, name: String, count: Int, icon: String, currency: String) -> IncomeCD?
    func saveAccountCell(budgetId: Int, name: String, count: Int, icon: String, currency: String) -> AccountCD?
    func saveSpendingCell(budgetId: Int, name: String, count: Int, icon: String, currency: String) -> SpendingCD?
}

protocol AddCellInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didSaveCell(incomeCD: IncomeCD)
    func didSaveAccountCell(accountCD: AccountCD)
    func didSaveSpendingCell(spendingCD: SpendingCD)
}

