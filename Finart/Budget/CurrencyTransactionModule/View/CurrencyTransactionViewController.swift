//
//  CurrencyTransactionViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 19.05.2022.
//

import UIKit

class CurrencyTransactionViewController: UIViewController {
    let currencyTransactionView = CurrencyTransactionView()
    var presenter: CurrencyTransactionPresenterProtocol?
    var sourceTitleLabel: String = ""
    var destinationTitleLabel: String = ""
    var isAccountDestination = false
    var date = Date()
    
    override func loadView() {
        super.loadView()
        view = currencyTransactionView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currencyTransactionView.countField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        presenter?.viewDidLoad()
        setup()
        setupNavigationItems()
    }
    
}

//MARK: - Private methods
extension CurrencyTransactionViewController {
    private func setup() {
        currencyTransactionView.update(name: "Введите сумму")
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
        guard let textCount = currencyTransactionView.countField.text else { return }
        guard let count = Int(textCount) else { return }
        guard let secondTextCount = currencyTransactionView.secondCountField.text else { return }
        guard let secondCount = Int(secondTextCount) else { return }
        guard let fromCell = presenter?.fromCell else { return }
        guard let toCell = presenter?.toCell else { return }
        
        presenter?.addTransaction(fromCell: fromCell,
                                  toCell: toCell,
                                  name: "Transaction",
                                  count: count,
                                  secondCount: secondCount,
                                  date: date)
    }
    
}


//MARK: - CurrencyTransactionViewProtocol
extension CurrencyTransactionViewController: CurrencyTransactionViewProtocol {
    func reloadIncome(with incomeViewModel: IncomeViewModel) {
        sourceTitleLabel += incomeViewModel.name
        let symbol = giveCurrencyVM(currency: incomeViewModel.currency).symbol
        currencyTransactionView.supportCountLabel.text = symbol
    }
    
    func reloadAccount(with accountViewModel: AccountViewModel) {
        switch presenter?.toCellType {
        case .income:
            destinationTitleLabel += "\(accountViewModel.name)"
            let symbol = giveCurrencyVM(currency: accountViewModel.currency).symbol
            currencyTransactionView.secondSupportCountLabel.text = symbol
            navigationItem.title = sourceTitleLabel + " → " + destinationTitleLabel
        case .account:
            if isAccountDestination {
                destinationTitleLabel += "\(accountViewModel.name)"
                let symbol = giveCurrencyVM(currency: accountViewModel.currency).symbol
                currencyTransactionView.secondSupportCountLabel.text = symbol
                navigationItem.title = sourceTitleLabel + " → " + destinationTitleLabel
                isAccountDestination = false
            } else {
                sourceTitleLabel += "\(accountViewModel.name)"
                let symbol = giveCurrencyVM(currency: accountViewModel.currency).symbol
                currencyTransactionView.supportCountLabel.text = symbol
                isAccountDestination = true
            }
        case .spending:
            let symbol = giveCurrencyVM(currency: accountViewModel.currency).symbol
            currencyTransactionView.supportCountLabel.text = symbol
            sourceTitleLabel += "\(accountViewModel.name)"
        case .none:
            print("Error in switch TransactionController")
        }
    }
    
    func reloadSpending(with spendingViewModel: SpendingViewModel) {
        destinationTitleLabel += "\(spendingViewModel.name)"
        let symbol = giveCurrencyVM(currency: spendingViewModel.currency).symbol
        currencyTransactionView.secondSupportCountLabel.text = symbol
        navigationItem.title = sourceTitleLabel + " → " + destinationTitleLabel
    }
    
}
