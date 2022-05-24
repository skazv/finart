//
//  UpdateBudgetViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 15.05.2022.
//

import UIKit

class UpdateBudgetViewController: UIViewController {
    let updateView = UpdateBudgetView()
    var presenter: UpdateBudgetPresenterProtocol?
    var reportDay: Date?
    var iconName: String?
    var currencyName: String?
    let settingsArray: [SettignsSection] = [
        SettignsSection(name: "Основные", settingsCell: [
            SettignsCell(icon: IconLib.reportFirstDay.image, name: "Дата начала"),
            SettignsCell(icon: IconLib.banknote.image, name: "Основная валюта"),
        ]),
    ]
    
    override func loadView() {
        super.loadView()
        view = updateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setup()
        setupNavigationItems()
    }
    
}

//MARK: - Private methods
extension UpdateBudgetViewController {
    private func setup() {
        title = "Редактирование бюджета"
        
        updateView.settingsTableView.register(SettingsViewCell.self, forCellReuseIdentifier: "settings")
        updateView.settingsTableView.register(DataPickerViewCell.self, forCellReuseIdentifier: "data")
        updateView.settingsTableView.dataSource = self
        updateView.settingsTableView.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(iconTapped))
        updateView.iconImageView.addGestureRecognizer(gesture)
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
        guard let name = updateView.titleTextField.text else { return }
        guard let reportDay = reportDay else { return }

        presenter?.updateBudget(name: name,
                                icon: self.iconName,
                                reportDay: reportDay,
                                currency: "RUB")
        
        presenter?.closeView()
    }
    
    @objc private func iconTapped() {
        presenter?.chooseIcon()
    }
}


//MARK: - UpdateBudgetViewProtocol
extension UpdateBudgetViewController: UpdateBudgetViewProtocol {
    func didChooseCurrency(currencyName: String) {
        self.currencyName = currencyName
        guard let cell = updateView.settingsTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? SettingsViewCell else { return }
        let currerncyVM = giveCurrencyVM(currency: currencyName)
        cell.currencyNameLabel.text = currerncyVM.name
        cell.currencySymbolLabel.text = currerncyVM.symbol
    }
    
    
    func didFetchBudget(budget: BudgetViewModel) {
        updateView.iconImageView.image = budget.icon
        updateView.titleTextField.text = budget.name
        reportDay = budget.reportDay
        currencyName = budget.currency
        //iconName = "ipod"
        
//        if let cell = updateView.settingsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? DataPickerViewCell {
//            cell.dataPicker.date = budget.reportDay
//        }
        
    }
    
    func didChooseImage(iconName: String) {
        self.iconName = iconName
        updateView.iconImageView.image = UIImage(systemName: iconName)
    }
    
}

//MARK: - UITableViewDataSource
extension UpdateBudgetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsArray[section].name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingsArray[section].settingsCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "data", for: indexPath) as? DataPickerViewCell else { return UITableViewCell() }
            cell.nameLabel.text = settingsArray[indexPath.section].settingsCell[indexPath.row].name
            cell.iconImageView.image = settingsArray[indexPath.section].settingsCell[indexPath.row].icon
            cell.dataPicker.date = reportDay ?? Date()
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath) as? SettingsViewCell else { return UITableViewCell() }
            cell.nameLabel.text = settingsArray[indexPath.section].settingsCell[indexPath.row].name
            cell.iconImageView.image = settingsArray[indexPath.section].settingsCell[indexPath.row].icon
            cell.selectionStyle = .none
            //NEW
            let currerncyVM = giveCurrencyVM(currency: currencyName ?? "USD")
            cell.currencyNameLabel.text = currerncyVM.name
            cell.currencySymbolLabel.text = currerncyVM.symbol
            //NEW
            return cell
        }
    }
    
}

//MARK: - UITableViewDelegate
extension UpdateBudgetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.frame.height / 15
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            presenter?.chooseCurrency()
        }
    }
    
}

//MARK: - ReportDayDelegate
extension UpdateBudgetViewController: ReportDayDelegate {
    func changeReportDay(date: Date) {
        reportDay = date
    }
}
