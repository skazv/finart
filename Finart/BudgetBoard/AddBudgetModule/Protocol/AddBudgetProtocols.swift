//
//  AddBudgetProtocols.swift
//  Finart
//
//  Created by Suren Kazaryan on 08.05.2022.
//

import UIKit

protocol AddBudgetDelegate: AnyObject {
    func didAddBudget(budgetCD: BudgetCD)
}

protocol AddBudgetViewProtocol: AnyObject {
    var presenter: AddBudgetPresenterProtocol? { get set }
    var reportDay: Date? { get set }
    var iconName: String? { get set }
    var currencyName: String? { get set }

    // PRESENTER -> VIEW
    func didChooseImage(iconName: String)
    func didChooseCurrency(currencyName: String)
}

protocol AddBudgetPresenterProtocol: AnyObject {
    var view: AddBudgetViewProtocol? { get set }
    var interactor: AddBudgetInteractorInputProtocol? { get set }
    var router: AddBudgetRouterProtocol? { get set }
    var delegate: AddBudgetDelegate? { get set }
    
    // VIEW -> PRESENTER
    func addBudget(name: String, icon: String, reportDay: Date, currency: String)
    func chooseCurrency()
    func chooseIcon()
    func closeView()
}

protocol AddBudgetRouterProtocol: AnyObject {
    static func createAddBudgetModul(with delegate: AddBudgetDelegate) -> UIViewController
    
    // PRESENTER -> ROUTER
    func dismissAddBudget(from view: AddBudgetViewProtocol, completion: (() -> Void)?)
    func presentIconsScreen(from view: AddBudgetViewProtocol)
    func presentCurrencyScreen(from view: AddBudgetViewProtocol)
}

protocol AddBudgetInteractorInputProtocol: AnyObject {
    var presenter: AddBudgetInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func addBudget(name: String, icon: String, reportDate: Date, currency: String)
}

protocol AddBudgetInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didAddBudget(budgetCD: BudgetCD)
}
