//
//  BudgetTablesRouter.swift
//  Finart
//
//  Created by Suren Kazaryan on 05.05.2022.
//

import UIKit

class BudgetTablesRouter: BudgetTablesRouterProtocol {
    static func createBudgetTablesModul(with delegate: BudgetTablesDelegate, budgetId: Int) -> UIViewController {
        let viewController = BudgetTablesViewController()
        let presenter: BudgetTablesPresenterProtocol & BudgetTablesInteractorOutputProtocol = BudgetTablesPresenter()
        let router: BudgetTablesRouterProtocol = BudgetTablesRouter()
        let interactor: BudgetTablesInteractorInputProtocol = BudgetTablesInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        presenter.budgetId = budgetId
        interactor.presenter = presenter
        
        return viewController
    }
    
//    func presentUpdateBudgetScreen(from view: BudgetTablesViewProtocol, budgetId: Int) {
////        guard let delegate = view.presenter as? UpdateBudgetDelegate else { return }
////        let updateBudgetVC = UINavigationController(rootViewController: UpdateBudgetRouter.createUpdateBudgetModul(with: delegate, budgetId: budgetId))
////
////        guard let viewVC = view as? UIViewController else {
////            fatalError("Invalid protocol")
////        }
////
////        updateBudgetVC.modalPresentationStyle = .fullScreen
////        viewVC.navigationController?.present(updateBudgetVC, animated: true, completion: nil)
//    }
    
    func dismissBudgetTables(from view: BudgetTablesViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
