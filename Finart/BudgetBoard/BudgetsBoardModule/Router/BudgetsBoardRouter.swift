//
//  BudgetsBoardRouter.swift
//  Finart
//
//  Created by Suren Kazaryan on 08.05.2022.
//

import UIKit

class BudgetsBoardRouter: BudgetsBoardRouterProtocol {
    static func createBudgetsBoardModul(with delegate: BudgetsBoardDelegate) -> UIViewController {
        let viewController = BudgetsBoardViewController()
        let presenter: BudgetsBoardPresenterProtocol & BudgetsBoardInteractorOutputProtocol = BudgetsBoardPresenter()
        let router: BudgetsBoardRouterProtocol = BudgetsBoardRouter()
        let interactor: BudgetsBoardInteractorInputProtocol = BudgetsBoardInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return viewController
    }
    
    func dismissBudgetsBoard(from view: BudgetsBoardViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            
            view.dismiss(animated: true)
        }
    }
    
}
