//
//  AddCellRouter.swift
//  Finart
//
//  Created by Suren Kazaryan on 23.04.2022.
//

import Foundation
import UIKit

class AddCellRouter: AddCellRouterProtocol {
    static func createAddCellModul(with delegate: AddCellDelegate, budgetId: Int, cellType: CellType, currency: String) -> UIViewController {
        let addCellVC = AddCellViewController()
        let presenter: AddCellPresenterProtocol & AddCellInteractorOutputProtocol = AddCellPresenter()
        let router: AddCellRouterProtocol = AddCellRouter()
        let interactor: AddCellInteractorInputProtocol = AddCellInteractor()
        
        addCellVC.presenter = presenter
        presenter.view = addCellVC
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        presenter.budgetId = budgetId
        presenter.cellType = cellType
        presenter.currency = currency
        interactor.presenter = presenter

        return addCellVC
    }
    
    func dismissAddCell(from view: AddCellViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
    func presentIconsScreen(from view: AddCellViewProtocol) {
        guard let delegate = view.presenter as? IconsDelegate else { return }
        let iconsVC =  IconsRouter.createIconsModul(with: delegate)
    
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid protocol")
        }
    
        viewVC.navigationController?.present(iconsVC, animated: true, completion: nil)
    }
    
    func presentCurrencyScreen(from view: AddCellViewProtocol) {
        guard let delegate = view.presenter as? CurrencyDelegate else { return }
        let currencyVC =  CurrencyRouter.createCurrencyModul(with: delegate)
    
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid protocol")
        }
    
        viewVC.navigationController?.present(currencyVC, animated: true, completion: nil)
    }
    
}
