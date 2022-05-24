//
//  BudgetTablesViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 05.05.2022.
//

import UIKit

class BudgetTablesViewController: UIViewController {
    let budgetTablesView = BudgetTablesView()
    var presenter: BudgetTablesPresenterProtocol?
    var budgetArr: [BudgetViewModel] = []
    
    override func loadView() {
        super.loadView()
        view = budgetTablesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.viewDidLoad()
    }
    
}

//MARK: - Private methods
extension BudgetTablesViewController {
    private func setup() {
        budgetTablesView.tableView.register(BudgetTableViewCell.self, forCellReuseIdentifier: "cell")
        budgetTablesView.tableView.register(AddBudgetCell.self, forCellReuseIdentifier: "AddBudgetCell")
        budgetTablesView.tableView.dataSource = self
        budgetTablesView.tableView.delegate = self
    }
}


//MARK: - BudgetTablesViewProtocol
extension BudgetTablesViewController: BudgetTablesViewProtocol {
    func didDeleteBudget(with row: Int) {
        print("delete")
    }
    
    func didFetchBudgets(budget: [BudgetViewModel]) {
        budgetArr = budget
        budgetArr.append(BudgetViewModel(name: "   Добавить бюджет",
                                         icon: UIImage(systemName: "plus.app") ?? .add,
                                         reportDay: Date(),
                                         currency: ""
                                        ))
    }
    
    func didAddBudget(budget: BudgetViewModel) {
        budgetArr.append(budget)
    }
    
}

//MARK: - UITableViewDataSource
extension BudgetTablesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        budgetArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == budgetArr.count - 1 && indexPath.section == 0 && isEditing == false {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddBudgetCell", for: indexPath) as? AddBudgetCell else { return UITableViewCell() }
            cell.updateCell(name: "Добавить бюджет", image: budgetArr[indexPath.row].icon)
            return cell
        } else {
            if let budgetId = presenter?.budgetId {
                if indexPath.row == budgetId {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BudgetTableViewCell else { return UITableViewCell() }
                    cell.updateCell(name: budgetArr[indexPath.row].name, image: budgetArr[indexPath.row].icon, isCurrent: true)
                    cell.delegate = self
                    return cell
                } else {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BudgetTableViewCell else { return UITableViewCell() }
                    cell.updateCell(name: budgetArr[indexPath.row].name, image: budgetArr[indexPath.row].icon, isCurrent: false)
                    cell.delegate = self
                    return cell
                }
            }
            return UITableViewCell()
        }
    }
    
}

//MARK: - UITableViewDelegate
extension BudgetTablesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.frame.width / 8
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == budgetArr.count - 1 {
            presenter?.closeViewAndOpenAddBudget()
        } else {
            presenter?.chooseBudget(id: indexPath.row)
        }
    }
    
    //MARK: - Исправить по VIPER
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if budgetArr.count > 2 {
                presenter?.deleteBudget(with: indexPath.row)
                budgetArr.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                if indexPath.row != 0 {
                    presenter?.chooseBudget(id: indexPath.row - 1)
                    UserDefaultsManager.setStartBudget(id: indexPath.row - 1)
                } else {
                    presenter?.chooseBudget(id: indexPath.row)
                    UserDefaultsManager.setStartBudget(id: indexPath.row)
                }
            } else {
                showAlarm(navigation: self, title: "Ошибка", message: "Нельзя удалить единственный бюджет")
            }
        }
    }
    
}

//MARK: - UpdateBudgetCellDelegate
extension BudgetTablesViewController: UpdateBudgetCellDelegate {
    func updateCell(cell: BudgetTableViewCell) {
        if let indexPath = budgetTablesView.tableView.indexPath(for: cell) {
            presenter?.closeViewAndOpenUpdateBudget(budgetId: indexPath.row)
        }
    }
        
}
