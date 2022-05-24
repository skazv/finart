//
//  BudgetsBoardProtocols.swift
//  Finart
//
//  Created by Suren Kazaryan on 08.05.2022.
//

import UIKit

protocol BudgetsBoardDelegate: AnyObject {
}

protocol BudgetsBoardViewProtocol: AnyObject {
    var presenter: BudgetsBoardPresenterProtocol? { get set }

    // PRESENTER -> VIEW
    func didFetchBudgets(budgets: [BudgetViewModel])
}

protocol BudgetsBoardPresenterProtocol: AnyObject {
    var view: BudgetsBoardViewProtocol? { get set }
    var interactor: BudgetsBoardInteractorInputProtocol? { get set }
    var router: BudgetsBoardRouterProtocol? { get set }
    var delegate: BudgetsBoardDelegate? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func closeView()
}

protocol BudgetsBoardRouterProtocol: AnyObject {
    static func createBudgetsBoardModul(with delegate: BudgetsBoardDelegate) -> UIViewController
    
    // PRESENTER -> ROUTER
    func dismissBudgetsBoard(from view: BudgetsBoardViewProtocol, completion: (() -> Void)?)
}

protocol BudgetsBoardInteractorInputProtocol: AnyObject {
    var presenter: BudgetsBoardInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchBudgets()
}

protocol BudgetsBoardInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didFetchBudgets(budgetsCD: [BudgetCD])
}
