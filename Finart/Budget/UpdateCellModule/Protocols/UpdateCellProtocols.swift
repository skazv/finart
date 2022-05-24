//
//  UpdateCellProtocols.swift
//  Finart
//
//  Created by Suren Kazaryan on 28.04.2022.
//

import UIKit

protocol UpdateCellDelegate: AnyObject {
    //func didUpdateCell(cellType: CellType, cellRow: Int, name: String, count: Int, icon: String)
    func didUpdateCell(cellType: CellType, incomeCD: IncomeCD?, accountCD: AccountCD?, spendingCD: SpendingCD?)
}

protocol UpdateCellViewProtocol: AnyObject {
    var presenter: UpdateCellPresenterProtocol? { get set }
    var iconName: String? { get set }
    
    // PRESENTER -> VIEW
    func didChooseImage(iconName: String)
    func reloadIncome(with incomeViewModel: IncomeViewModel)
    func reloadAccount(with accountViewModel: AccountViewModel)
    func reloadSpending(with spendingViewModel: SpendingViewModel)
}

protocol UpdateCellPresenterProtocol: AnyObject {
    var view: UpdateCellViewProtocol? { get set }
    var interactor: UpdateCellInteractorInputProtocol? { get set }
    var router: UpdateCellRouterProtocol? { get set }
    var delegate: UpdateCellDelegate? { get set }
    var budgetId: Int? { get set }
    var cellType: CellType? { get set }
    var cellRow: Int? { get set }

    // VIEW -> PRESENTER
    func viewDidLoad()
    func updateCell(name: String, count: Int, icon: String?)
    func closeView()
    func chooseIcon()
}

protocol UpdateCellRouterProtocol: AnyObject {
    static func createUpdateCellModul(with delegate: UpdateCellDelegate, budgetId: Int, cellType: CellType, cellRow: Int) -> UIViewController
    
    // PRESENTER -> ROUTER
    func dismissUpdateCell(from view: UpdateCellViewProtocol, completion: (() -> Void)?)
    func presentIconsScreen(from view: UpdateCellViewProtocol)
}

protocol UpdateCellInteractorInputProtocol: AnyObject {
    var presenter: UpdateCellInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func updateCell(budgetId: Int, cellType: CellType, cellRow: Int, name: String, count: Int, icon: String?)
    func fetchCell(budgetId: Int, cellType: CellType, row: Int)
}

protocol UpdateCellInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
//    func didUpdateCell(cellType: CellType, cellRow: Int, name: String, count: Int, icon: String)
    func didUpdateCell(cellType: CellType, incomeCD: IncomeCD?, accountCD: AccountCD?, spendingCD: SpendingCD?)
    func didFetchIncome(income: IncomeCD)
    func didFetchAccount(account: AccountCD)
    func didFetchSpending(spending: SpendingCD)
}
