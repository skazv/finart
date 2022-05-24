//
//  CurrencyTransactionRouter.swift
//  Finart
//
//  Created by Suren Kazaryan on 19.05.2022.
//

import UIKit

class CurrencyTransactionRouter: CurrencyTransactionRouterProtocol {
    static func createCurrencyTransactionModul(with delegate: CurrencyTransactionDelegate, budgetId: Int, toCellType: CellType, fromCell: Int, toCell: Int) -> UIViewController {
        let viewController = CurrencyTransactionViewController()
        let presenter: CurrencyTransactionPresenterProtocol & CurrencyTransactionInteractorOutputProtocol = CurrencyTransactionPresenter()
        let router: CurrencyTransactionRouterProtocol = CurrencyTransactionRouter()
        let interactor: CurrencyTransactionInteractorInputProtocol = CurrencyTransactionInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        presenter.toCellType = toCellType
        presenter.budgetId = budgetId
        presenter.fromCell = fromCell
        presenter.toCell = toCell
        interactor.presenter = presenter
        
        return viewController
    }
    
    func dismissCurrencyTransaction(from view: CurrencyTransactionViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
