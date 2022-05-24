//
//  TransactionRouter.swift
//  Finart
//
//  Created by Suren Kazaryan on 20.04.2022.
//

import UIKit

class TransactionRouter: TransactionRouterProtocol {
    static func createTransactionModul(with delegate: TransactionDelegate, budgetId: Int, toCellType: CellType, fromCell: Int, toCell: Int) -> UIViewController {
        let transactionVC = TransactionViewController()
        let presenter: TransactionPresenterProtocol & TransactionInteractorOutputProtocol = TransactionPresenter()
        let interactor: TransactionInteractorInputProtocol = TransactionInteractor()
        let router: TransactionRouterProtocol = TransactionRouter()
        
        transactionVC.presenter = presenter
        presenter.view = transactionVC
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        presenter.budgetId = budgetId
        presenter.fromCell = fromCell
        presenter.toCellType = toCellType
        presenter.toCell = toCell
        
        interactor.presenter = presenter
        
        return transactionVC
    }
    
    
    func dismissAddCell(from view: TransactionViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
    
}
