//
//  CellDetailViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 26.04.2022.
//

import UIKit

class CellDetailViewController: UIViewController {
    var presenter: CellDetailPresenterProtocol?
    let cellDetailView = CellDetailView()
    var transactionsArray: [TransactionViewModel]?
    var isIncome: Bool?
    
    override func loadView() {
        super.loadView()
        view = cellDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.viewDidLoad()
    }
    
}

//MARK: - Private methods
extension CellDetailViewController {
    private func setup() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        
        //cellDetailView.editButtom.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        
        cellDetailView.tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "cell")
        cellDetailView.tableView.dataSource = self
        cellDetailView.tableView.delegate = self
    }
    
    @objc private func editTapped() {
        guard let cellType = presenter?.cellType else { return }
        guard let cellRow = presenter?.row else { return }
        presenter?.updateCell(from: self, cellType: cellType, cellRow: cellRow)
    }
    
}

//MARK: - CellDetailViewProtocol
extension CellDetailViewController: CellDetailViewProtocol {
    
    func reloadIncome(with incomeViewModel: IncomeViewModel) {
        cellDetailView.updateView(title: incomeViewModel.name,
                                  count: String(incomeViewModel.count),
                                  image: incomeViewModel.icon)
    }
    
    func reloadAccount(with accountViewModel: AccountViewModel) {
        cellDetailView.updateView(title: accountViewModel.name,
                                  count: String(accountViewModel.count),
                                  image: accountViewModel.icon)
    }
    
    func reloadSpending(with spendingViewModel: SpendingViewModel) {
        cellDetailView.updateView(title: spendingViewModel.name,
                                  count: String(spendingViewModel.count),
                                  image: spendingViewModel.icon)
    }
    
    func reloadTransactions(transactions: [TransactionViewModel]) {
        transactionsArray = transactions
    }
    
}

//MARK: - UITableViewDataSource
extension CellDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let transactionsArray = transactionsArray else { return 0 }
        return transactionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TransactionTableViewCell else { return UITableViewCell() }
        
        if let transactionsArray = transactionsArray {
            
            cell.iconImageView.image = transactionsArray[indexPath.row].icon
            cell.nameLabel.text = transactionsArray[indexPath.row].name
            if transactionsArray[indexPath.row].isSource {
                cell.countLabel.text = "+\(transactionsArray[indexPath.row].count)"
                cell.countLabel.textColor = .green
            } else {
                cell.countLabel.text = "-\(transactionsArray[indexPath.row].count)"
                cell.countLabel.textColor = .red
            }
    
        }
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension CellDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.frame.height / 14
        return height
    }
    
    //MARK: - Исправить по VIPER
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if var transactionsArray = transactionsArray {
                let identificator = transactionsArray[indexPath.row].identificator
                presenter?.deleteTransaction(identificator: identificator)
                transactionsArray.remove(at: indexPath.row)
                presenter?.viewDidLoad()
                tableView.deleteRows(at: [indexPath], with: .left)
            }
        }
    }
    
}
