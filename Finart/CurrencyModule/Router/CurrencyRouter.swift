//
//  CurrencyRouter.swift
//  Finart
//
//  Created by Suren Kazaryan on 16.05.2022.
//

import UIKit

class CurrencyRouter: CurrencyRouterProtocol {
    static func createCurrencyModul(with delegate: CurrencyDelegate) -> UIViewController {
        let viewController = CurrencyViewController()
        let presenter: CurrencyPresenterProtocol & CurrencyInteractorOutputProtocol = CurrencyPresenter()
        let router: CurrencyRouterProtocol = CurrencyRouter()
        let interactor: CurrencyInteractorInputProtocol = CurrencyInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return viewController
    }
    
    func dismissCurrency(from view: CurrencyViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
