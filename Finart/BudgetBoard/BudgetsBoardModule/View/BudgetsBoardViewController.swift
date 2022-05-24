//
//  BudgetsBoardViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 08.05.2022.
//

import UIKit

class BudgetsBoardViewController: UIViewController {
    let budgetsBoardView = BudgetsBoardView()
    var presenter: BudgetsBoardPresenterProtocol?
    
    override func loadView() {
        super.loadView()
        view = budgetsBoardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setup()
        setupNavigationItems()
    }
    
}

//MARK: - Private methods
extension BudgetsBoardViewController {
    private func setup() {
    }
    
    private func setupNavigationItems() {
        //navigationController?.title = "\(source) -> \(destination)"
        title = "Бюджеты"
        
        let closeImage = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: closeImage, style: .done, target: self, action: #selector(closeTapped))
        
        let profileItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTaped))
        let editItem = UIBarButtonItem(image: IconLib.chartPie.image, style: .done, target: self, action: #selector(editTaped))
        
        navigationItem.rightBarButtonItems = [profileItem, editItem]
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTaped))
    }
    
    @objc private func closeTapped() {
        presenter?.closeView()
    }
    
    @objc private func editTaped() {
        if budgetsBoardView.budgetsBoardColletion.isEditing {
            budgetsBoardView.budgetsBoardColletion.isEditing = false
            budgetsBoardView.budgetsBoardColletion.reloadData()
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTaped))
        } else {
            budgetsBoardView.budgetsBoardColletion.isEditing = true
            budgetsBoardView.budgetsBoardColletion.reloadData()
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTaped))
        }
    }
    
    
}


//MARK: - BudgetsBoardViewProtocol
extension BudgetsBoardViewController: BudgetsBoardViewProtocol {
    func didFetchBudgets(budgets: [BudgetViewModel]) {
        budgetsBoardView.budgetsBoardColletion.budgetsArray = budgets
    }
    
}
