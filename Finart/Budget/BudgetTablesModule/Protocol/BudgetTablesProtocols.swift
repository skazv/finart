//
//  BudgetTablesProtocols.swift
//  Finart
//
//  Created by Suren Kazaryan on 05.05.2022.
//

import UIKit

protocol BudgetTablesDelegate: AnyObject {
    func openAddBudget()
    func openUpdateBudget(budgetId: Int)
    func reloadAllItems(budgetId: Int)
}

protocol BudgetTablesViewProtocol: AnyObject {
    var presenter: BudgetTablesPresenterProtocol? { get set }

    // PRESENTER -> VIEW
    func didFetchBudgets(budget: [BudgetViewModel])
    func didAddBudget(budget: BudgetViewModel)
    func didDeleteBudget(with row: Int)
}

protocol BudgetTablesPresenterProtocol: AnyObject {
    var view: BudgetTablesViewProtocol? { get set }
    var interactor: BudgetTablesInteractorInputProtocol? { get set }
    var router: BudgetTablesRouterProtocol? { get set }
    var delegate: BudgetTablesDelegate? { get set }
    var budgetId: Int? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func chooseBudget(id: Int)
    func closeViewAndOpenAddBudget()
    func deleteBudget(with row: Int)
    func closeViewAndOpenUpdateBudget(budgetId: Int)
}

protocol BudgetTablesRouterProtocol: AnyObject {
    static func createBudgetTablesModul(with delegate: BudgetTablesDelegate, budgetId: Int) -> UIViewController
    
    // PRESENTER -> ROUTER
    //func presentUpdateBudgetScreen(from view: BudgetTablesViewProtocol, budgetId: Int)
    func dismissBudgetTables(from view: BudgetTablesViewProtocol, completion: (() -> Void)?)
}

protocol BudgetTablesInteractorInputProtocol: AnyObject {
    var presenter: BudgetTablesInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchBudgets()
    func deleteBudget(with row: Int)
}

protocol BudgetTablesInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didFetchBudgets(budgetsCD: [BudgetCD])
    func didDeleteBudget(with row: Int)
}
