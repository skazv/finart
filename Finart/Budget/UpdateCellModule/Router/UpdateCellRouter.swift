//
//  UpdateCellRouter.swift
//  Finart
//
//  Created by Suren Kazaryan on 28.04.2022.
//

import UIKit

class UpdateCellRouter: UpdateCellRouterProtocol {
    
    static func createUpdateCellModul(with delegate: UpdateCellDelegate, budgetId: Int, cellType: CellType, cellRow: Int) -> UIViewController {
        let viewController = UpdateCellViewController()
        let presenter: UpdateCellPresenterProtocol & UpdateCellInteractorOutputProtocol = UpdateCellPresenter()
        let router: UpdateCellRouterProtocol = UpdateCellRouter()
        let interactor: UpdateCellInteractorInputProtocol = UpdateCellInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        presenter.budgetId = budgetId
        presenter.cellType = cellType
        presenter.cellRow = cellRow
        interactor.presenter = presenter
        
        return viewController
    }
    
    func dismissUpdateCell(from view: UpdateCellViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
    func presentIconsScreen(from view: UpdateCellViewProtocol) {
        guard let delegate = view.presenter as? IconsDelegate else { return }
        let iconsVC =  IconsRouter.createIconsModul(with: delegate)
    
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid protocol")
        }
    
        viewVC.navigationController?.present(iconsVC, animated: true, completion: nil)
    }
    
}
