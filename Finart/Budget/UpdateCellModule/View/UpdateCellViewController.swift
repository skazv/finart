//
//  UpdateCellViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 28.04.2022.
//

import UIKit

class UpdateCellViewController: UIViewController {
    let updateCellView = UpdateCellView()
    var presenter: UpdateCellPresenterProtocol?
    var iconName: String?
    
    override func loadView() {
        super.loadView()
        view = updateCellView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationItems()
        presenter?.viewDidLoad()
    }
    
}

//MARK: - Private methods
extension UpdateCellViewController {
    private func setup() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(iconTapped))
        updateCellView.iconImageView.addGestureRecognizer(gesture)
        
        guard let cellType = presenter?.cellType else { return }
        switch cellType {
        case .income:
            updateCellView.updateAdd(title: "Изменить доход", support: "Ежемесячный план")
        case .account:
            updateCellView.updateAdd(title: "Изменить баланс", support: "Текущий баланс")
        case .spending:
            updateCellView.updateAdd(title: "Изменить расход", support: "Ежемесячный план")
        }
    }
    
    private func setupNavigationItems() {
        let closeImage = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: closeImage, style: .done, target: self, action: #selector(closeTapped))
        
        let doneImage = UIImage(systemName: "checkmark")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: doneImage, style: .done, target: self, action: #selector(doneTapped))
    }
    
    @objc private func closeTapped() {
        presenter?.closeView()
    }
    
    @objc private func doneTapped() {
        guard let name = updateCellView.titleTextField.text else { return }
        guard let textCount = updateCellView.countTextField.text else { return }
        guard let count = Int(textCount) else { return }
        
        presenter?.updateCell(name: name, count: count, icon: self.iconName)
    }
    
    @objc private func iconTapped() {
        presenter?.chooseIcon()
    }
    
}


//MARK: - UpdateCellViewProtocol
extension UpdateCellViewController: UpdateCellViewProtocol {
    
    func reloadIncome(with incomeViewModel: IncomeViewModel) {
        updateCellView.updateView(title: incomeViewModel.name,
                                  count: String(incomeViewModel.planCount),
                                  image: incomeViewModel.icon)
    }
    
    func reloadAccount(with accountViewModel: AccountViewModel) {
        updateCellView.updateView(title: accountViewModel.name,
                                   count: String(accountViewModel.count),
                                   image: accountViewModel.icon)
    }
    
    func reloadSpending(with spendingViewModel: SpendingViewModel) {
        updateCellView.updateView(title: spendingViewModel.name,
                                   count: String(spendingViewModel.planCount),
                                   image: spendingViewModel.icon)
    }
    
    func didChooseImage(iconName: String) {
        self.iconName = iconName
        updateCellView.iconImageView.image = UIImage(systemName: iconName)
    }
    
}
