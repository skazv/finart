//
//  BudgetRouter.swift
//  Finart
//
//  Created by Suren Kazaryan on 20.04.2022.
//

import UIKit

class BudgetRouter: BudgetRouterProtocol {
    
    static func createBudgetModul() -> UIViewController {
        let budgetViewController = BudgetViewController()
        let presenter: BudgetPresenterProtocol & BudgetInteractorOutputProtocol = BudgetPresenter()
        let interactor: BudgetInteractorInputProtocol = BudgetInteractor()
        let router = BudgetRouter()
        
        budgetViewController.presenter = presenter
        presenter.view = budgetViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return budgetViewController
    }
    
    func presentAddCellScreen(from view: BudgetViewProtocol, budgetId: Int, cellType: CellType, currency: String) {
        guard let delegate = view.presenter as? AddCellDelegate else { return }
        let addCellVC = UINavigationController(rootViewController:
                                                AddCellRouter.createAddCellModul(with: delegate,
                                                                                 budgetId: budgetId,
                                                                                 cellType: cellType,
                                                                                 currency: currency))
        
        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }
        
        addCellVC.modalPresentationStyle = .fullScreen
        viewVC.navigationController?.present(addCellVC, animated: true)
    }
    
    func presentCellDetailScreen(from view: BudgetViewProtocol, budgetId: Int, cellType: CellType, row: Int) {
        guard let delegate = view.presenter as? CellDetailDelegate else { return }
        let cellDetailVC = CellDetailRouter.createCellDetailModul(with: delegate, budgetId: budgetId, cellType: cellType, row: row)

        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }
        
        viewVC.navigationController?.pushViewController(cellDetailVC, animated: true)
    }
    
    func presentTransactionScreen(from view: BudgetViewProtocol, budgetId: Int, toCellType: CellType, fromCell: Int, toCell: Int) {
        guard let delegate = view.presenter as? TransactionDelegate else { return }
        let transactionVC = UINavigationController(rootViewController: TransactionRouter.createTransactionModul(
            with: delegate,
            budgetId: budgetId,
            toCellType: toCellType,
            fromCell: fromCell,
            toCell: toCell))
        
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid protocol")
        }
    
        transactionVC.modalPresentationStyle = .fullScreen
        viewVC.navigationController?.present(transactionVC, animated: true, completion: nil)
    }
    
    func presentCurrencyTransactionScreen(from view: BudgetViewProtocol, budgetId: Int, toCellType: CellType, fromCell: Int, toCell: Int) {
        guard let delegate = view.presenter as? CurrencyTransactionDelegate else { return }
        let currencyTransactionVC = UINavigationController(rootViewController: CurrencyTransactionRouter.createCurrencyTransactionModul(
            with: delegate,
            budgetId: budgetId,
            toCellType: toCellType,
            fromCell: fromCell,
            toCell: toCell))
        
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid protocol")
        }
    
        currencyTransactionVC.modalPresentationStyle = .fullScreen
        viewVC.navigationController?.present(currencyTransactionVC, animated: true, completion: nil)
    }
    
    func presentBudgetsTableScreen(from view: BudgetViewProtocol, budgetId: Int) {
        guard let delegate = view.presenter as? BudgetTablesDelegate else { return }
        let budgetsTableVC = BudgetTablesRouter.createBudgetTablesModul(with: delegate, budgetId: budgetId)

        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }

        budgetsTableVC.sheetPresentationController?.detents = [.medium(), .large()]
        budgetsTableVC.sheetPresentationController?.preferredCornerRadius = 30
        budgetsTableVC.sheetPresentationController?.prefersGrabberVisible = true
        viewVC.navigationController?.present(budgetsTableVC, animated: true)
    }
    
    func presentBudgetsBoardScreen(from view: BudgetViewProtocol) {
        guard let delegate = view.presenter as? BudgetsBoardDelegate else { return }
        let budgetsBoardVC = UINavigationController(rootViewController:
                                                        BudgetsBoardRouter.createBudgetsBoardModul(with: delegate))

        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }
        
//        budgetsBoardVC.modalTransitionStyle = .flipHorizontal
        budgetsBoardVC.modalPresentationStyle = .fullScreen
        
        viewVC.navigationController?.present(budgetsBoardVC, animated: true)
       // viewVC.modalPresentationStyle = .popover
       // viewVC.navigationController?.pushViewController(budgetsBoardVC, animated: true)

    }
    
    func presentAddBudgetScreen(from view: BudgetViewProtocol) {
        guard let delegate = view.presenter as? AddBudgetDelegate else { return }
        let addBudgetVC = UINavigationController(rootViewController: AddBudgetRouter.createAddBudgetModul(with: delegate))
        
        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }
        
        addBudgetVC.modalPresentationStyle = .fullScreen
        viewVC.navigationController?.present(addBudgetVC, animated: true)
    }
    
    func presentUpdateBudgetScreen(from view: BudgetViewProtocol, budgetId: Int) {
        guard let delegate = view.presenter as? UpdateBudgetDelegate else { return }
        let updateBudgetVC = UINavigationController(rootViewController: UpdateBudgetRouter.createUpdateBudgetModul(with: delegate, budgetId: budgetId))
        
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid protocol")
        }
        
        updateBudgetVC.modalPresentationStyle = .fullScreen
        viewVC.navigationController?.present(updateBudgetVC, animated: true, completion: nil)
    }
    
}
