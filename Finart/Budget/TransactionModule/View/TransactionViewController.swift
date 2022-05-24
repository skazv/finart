//
//  TransactionViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 20.04.2022.
//

import UIKit

protocol TransactionViewDelegate {
    func changeDate(date: Date)
}

class TransactionViewController: UIViewController {
    let transactionView = TransactionView()
    var presenter: TransactionPresenterProtocol?
    var sourceTitleLabel: String = ""
    var destinationTitleLabel: String = ""
    var isAccountDestination = false
    var date = Date()
    
    override func loadView() {
        super.loadView()
        view = transactionView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        transactionView.countField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        //title = "\(source) -> \(destination)"
        presenter?.viewDidLoad()
        setup()
        setupNavigationItems()
    }
    
}

//MARK: - Private methods
extension TransactionViewController {
    private func setup() {
        transactionView.update(name: "Введите сумму")
        transactionView.delegate = self
      //  transactionView
    }
    
    private func setupNavigationItems() {
        //navigationController?.title = "\(source) -> \(destination)"
        let closeImage = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: closeImage, style: .done, target: self, action: #selector(closeTapped))
        
        let doneImage = UIImage(systemName: "checkmark")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: doneImage, style: .done, target: self, action: #selector(doneTapped))
    }
    
    @objc private func closeTapped() {
        presenter?.closeView()
    }
    
    @objc private func doneTapped() {
        guard let textCount = transactionView.countField.text else { return }
        guard let count = Int(textCount) else { return }
        guard let fromCell = presenter?.fromCell else { return }
        guard let toCell = presenter?.toCell else { return }
        //let date = Date()

//        print("from \(fromCell) to \(toCell) count \(count) Date: \(date)")
        
        presenter?.addTransaction(fromCell: fromCell, toCell: toCell, name: "Transaction", count: count, date: date)
    }
    
}

//MARK: - Private methods
extension TransactionViewController: TransactionViewProtocol {
    
    func reloadIncome(with incomeViewModel: IncomeViewModel) {
        sourceTitleLabel += incomeViewModel.name
    }
    
    func reloadAccount(with accountViewModel: AccountViewModel) {
        
        switch presenter?.toCellType {
        case .income:
            destinationTitleLabel += "\(accountViewModel.name)"
            navigationItem.title = sourceTitleLabel + " → " + destinationTitleLabel
        case .account:
            if isAccountDestination {
                destinationTitleLabel += "\(accountViewModel.name)"
                navigationItem.title = sourceTitleLabel + " → " + destinationTitleLabel
                isAccountDestination = false
            } else {
                sourceTitleLabel += "\(accountViewModel.name)"
                isAccountDestination = true
            }
        case .spending:
            sourceTitleLabel += "\(accountViewModel.name)"
        case .none:
            print("Error in switch TransactionController")
        }
    }
    
    func reloadSpending(with spendingViewModel: SpendingViewModel) {
        destinationTitleLabel += "\(spendingViewModel.name)"
        navigationItem.title = sourceTitleLabel + " → " + destinationTitleLabel
    }
    
    
}


//MARK: - TransactionViewDelegate
extension TransactionViewController: TransactionViewDelegate {
    func changeDate(date: Date) {
        self.date = date
    }
    
}
