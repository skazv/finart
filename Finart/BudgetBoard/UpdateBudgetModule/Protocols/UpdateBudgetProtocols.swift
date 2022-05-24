//
//  UpdateBudgetProtocols.swift
//  Finart
//
//  Created by Suren Kazaryan on 15.05.2022.
//

import UIKit

protocol UpdateBudgetDelegate: AnyObject {
    func didUpdateBudget(budgetCD: BudgetCD)
}

protocol UpdateBudgetViewProtocol: AnyObject {
    var presenter: UpdateBudgetPresenterProtocol? { get set }
    var reportDay: Date? { get set }
    var iconName: String? { get set }
    var currencyName: String? { get set }

    // PRESENTER -> VIEW
    func didFetchBudget(budget: BudgetViewModel)
    func didChooseImage(iconName: String)
    func didChooseCurrency(currencyName: String)
}

protocol UpdateBudgetPresenterProtocol: AnyObject {
    var view: UpdateBudgetViewProtocol? { get set }
    var interactor: UpdateBudgetInteractorInputProtocol? { get set }
    var router: UpdateBudgetRouterProtocol? { get set }
    var delegate: UpdateBudgetDelegate? { get set }
    var budgetId: Int? { get set }

    // VIEW -> PRESENTER
    func viewDidLoad()
    func updateBudget(name: String, icon: String?, reportDay: Date, currency: String)
    func chooseCurrency()
    func chooseIcon()
    func closeView()
}

protocol UpdateBudgetRouterProtocol: AnyObject {
    static func createUpdateBudgetModul(with delegate: UpdateBudgetDelegate, budgetId: Int) -> UIViewController
    
    // PRESENTER -> ROUTER
    func dismissUpdateBudget(from view: UpdateBudgetViewProtocol, completion: (() -> Void)?)
    func presentIconsScreen(from view: UpdateBudgetViewProtocol)
    func presentCurrencyScreen(from view: UpdateBudgetViewProtocol)
}

protocol UpdateBudgetInteractorInputProtocol: AnyObject {
    var presenter: UpdateBudgetInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func updateBudget(budgetId: Int, name: String, icon: String?, reportDay: Date, currency: String)
    func fetchBudget(budgetId: Int)
}

protocol UpdateBudgetInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didFetchBudget(budgetsCD: BudgetCD)
    func didUpdateBudget(budgetCD: BudgetCD)
}
