//
//  UpdateBudgetRouter.swift
//  Finart
//
//  Created by Suren Kazaryan on 15.05.2022.
//

import UIKit

class UpdateBudgetRouter: UpdateBudgetRouterProtocol {
    static func createUpdateBudgetModul(with delegate: UpdateBudgetDelegate, budgetId: Int) -> UIViewController {
        let viewController = UpdateBudgetViewController()
        let presenter: UpdateBudgetPresenterProtocol & UpdateBudgetInteractorOutputProtocol = UpdateBudgetPresenter()
        let router: UpdateBudgetRouterProtocol = UpdateBudgetRouter()
        let interactor: UpdateBudgetInteractorInputProtocol = UpdateBudgetInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        presenter.budgetId = budgetId
        interactor.presenter = presenter
        
        return viewController
    }
    
    func presentIconsScreen(from view: UpdateBudgetViewProtocol) {
        guard let delegate = view.presenter as? IconsDelegate else { return }
        let iconsVC =  IconsRouter.createIconsModul(with: delegate)
    
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid protocol")
        }
    
        viewVC.navigationController?.present(iconsVC, animated: true, completion: nil)
    }
    
    func presentCurrencyScreen(from view: UpdateBudgetViewProtocol) {
        guard let delegate = view.presenter as? CurrencyDelegate else { return }
        let currencyVC =  CurrencyRouter.createCurrencyModul(with: delegate)
    
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid protocol")
        }
    
        viewVC.navigationController?.present(currencyVC, animated: true, completion: nil)
    }
    
    func dismissUpdateBudget(from view: UpdateBudgetViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
