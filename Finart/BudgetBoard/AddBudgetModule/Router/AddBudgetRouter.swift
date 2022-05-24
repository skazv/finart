//
//  AddBudgetRouter.swift
//  Finart
//
//  Created by Suren Kazaryan on 08.05.2022.
//

import UIKit

class AddBudgetRouter: AddBudgetRouterProtocol {
    static func createAddBudgetModul(with delegate: AddBudgetDelegate) -> UIViewController {
        let viewController = AddBudgetViewController()
        let presenter: AddBudgetPresenterProtocol & AddBudgetInteractorOutputProtocol = AddBudgetPresenter()
        let router: AddBudgetRouterProtocol = AddBudgetRouter()
        let interactor: AddBudgetInteractorInputProtocol = AddBudgetInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return viewController
    }
    
    func dismissAddBudget(from view: AddBudgetViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
    func presentIconsScreen(from view: AddBudgetViewProtocol) {
        guard let delegate = view.presenter as? IconsDelegate else { return }
        let iconsVC =  IconsRouter.createIconsModul(with: delegate)
    
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid protocol")
        }
    
        viewVC.navigationController?.present(iconsVC, animated: true, completion: nil)
    }
    
    func presentCurrencyScreen(from view: AddBudgetViewProtocol) {
        guard let delegate = view.presenter as? CurrencyDelegate else { return }
        let currencyVC =  CurrencyRouter.createCurrencyModul(with: delegate)
    
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid protocol")
        }
    
        viewVC.navigationController?.present(currencyVC, animated: true, completion: nil)
    }
    
}
