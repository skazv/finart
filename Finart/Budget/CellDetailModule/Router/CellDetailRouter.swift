//
//  CellDetailRouter.swift
//  Finart
//
//  Created by Suren Kazaryan on 26.04.2022.
//

import UIKit

class CellDetailRouter: CellDetailRouterProtocol {
    
    static func createCellDetailModul(with delegate: CellDetailDelegate, budgetId: Int, cellType: CellType, row: Int) -> UIViewController {
        let viewController = CellDetailViewController()
        let presenter: CellDetailPresenterProtocol & CellDetailInteractorOutputProtocol = CellDetailPresenter()
        let router: CellDetailRouterProtocol = CellDetailRouter()
        let interactor: CellDetailInteractorInputProtocol = CellDetailInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        presenter.budgetId = budgetId
        presenter.cellType = cellType
        presenter.row = row
        interactor.presenter = presenter
        
        return viewController
    }
    
    func dismissCellDetail(from view: CellDetailViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
    func presentUpdateCellScreen(from view: CellDetailViewProtocol, budgetId: Int, cellType: CellType, cellRow: Int) {
        guard let delegate = view.presenter as? UpdateCellDelegate else { return }
        let updateCellVC = UINavigationController(rootViewController: UpdateCellRouter.createUpdateCellModul(with: delegate, budgetId: budgetId, cellType: cellType, cellRow: cellRow))
        
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid protocol")
        }
     
        updateCellVC.modalPresentationStyle = .fullScreen
        viewVC.navigationController?.present(updateCellVC, animated: true, completion: nil)
        
    }
    
}
