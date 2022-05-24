//
//  AddBudgetViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 08.05.2022.
//

import UIKit

class AddBudgetViewController: UIViewController {
    let addBudgetView = AddBudgetView()
    var presenter: AddBudgetPresenterProtocol?
    let settingsArray: [SettignsSection] = [
        SettignsSection(name: "Основные", settingsCell: [
            SettignsCell(icon: IconLib.reportFirstDay.image, name: "Дата начала"),
            SettignsCell(icon: IconLib.banknote.image, name: "Основная валюта"),
//            SettignsCell(icon: IconLib.reportFirstDay.image, name: "Дата начала"),
            //isMain ДОБАВИТЬ!
       //     SettignsCell(icon: IconLib.calendar.image, name: "Отчетный период"),
        ]),
//        SettignsSection(name: "Оформление", settingsCell: [
//            SettignsCell(icon: IconLib.backgroundColor.image, name: "Цвет фона"),
//            SettignsCell(icon: IconLib.cellColor.image, name: "Цвет дохода"),
//            SettignsCell(icon: IconLib.cellColor.image, name: "Фон дохода"),
//            SettignsCell(icon: IconLib.cellColor.image, name: "Цвет баланса"),
//            SettignsCell(icon: IconLib.cellColor.image, name: "Фон баланса"),
//            SettignsCell(icon: IconLib.cellColor.image, name: "Цвет расхода"),
//            SettignsCell(icon: IconLib.cellColor.image, name: "Фон расхода"),
//        ])
    ]
    var reportDay: Date?
    var iconName: String?
    var currencyName: String?
    
    override func loadView() {
        super.loadView()
        view = addBudgetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationItems()
        hideKeyboardWhenTappedAround()
    }
    
}

//MARK: - Private methods
extension AddBudgetViewController {
    private func setup() {
        title = "Добавить бюджет"
        
        reportDay = giveAppCreatingDate()
        
        addBudgetView.settingsTableView.register(SettingsViewCell.self, forCellReuseIdentifier: "settings")
        addBudgetView.settingsTableView.register(DataPickerViewCell.self, forCellReuseIdentifier: "data")
        addBudgetView.settingsTableView.dataSource = self
        addBudgetView.settingsTableView.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(iconTapped))
        addBudgetView.iconImageView.addGestureRecognizer(gesture)
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
        guard let imageName = self.iconName else {
            showAlarm(navigation: self, title: "Ошибка", message: "Выберите иконку")
            return
        }
        guard let name = addBudgetView.titleTextField.text, addBudgetView.titleTextField.text != "" else {
            showAlarm(navigation: self, title: "Ошибка", message: "Введите название")
            return
        }
        guard let reportDay = reportDay else { return }
        
        presenter?.addBudget(name: name, icon: imageName, reportDay: reportDay, currency: currencyName ?? "USD")
        presenter?.closeView()
    }
    
    @objc private func iconTapped() {
        presenter?.chooseIcon()
    }
    
//    @objc private func currencyTapped() {
//        print("currencyTapped")
//    }
    
}

//MARK: - UITableViewDataSource
extension AddBudgetViewController: UITableViewDataSource {
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
            cell.dataPicker.date = giveAppCreatingDate()
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath) as? SettingsViewCell else { return UITableViewCell() }
            cell.nameLabel.text = settingsArray[indexPath.section].settingsCell[indexPath.row].name
            cell.iconImageView.image = settingsArray[indexPath.section].settingsCell[indexPath.row].icon
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
    }
    
}

//MARK: - UITableViewDelegate
extension AddBudgetViewController: UITableViewDelegate {
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

//MARK: - AddBudgetViewProtocol
extension AddBudgetViewController: AddBudgetViewProtocol {

    func didChooseCurrency(currencyName: String) {
        self.currencyName = currencyName
        guard let cell = addBudgetView.settingsTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? SettingsViewCell else { return }
        let currerncyVM = giveCurrencyVM(currency: currencyName)
        cell.currencyNameLabel.text = currerncyVM.name
        cell.currencySymbolLabel.text = currerncyVM.symbol
    }
    
    func didChooseImage(iconName: String) {
        self.iconName = iconName
        addBudgetView.iconImageView.image = UIImage(systemName: iconName)
        addBudgetView.chooseIconLabel.isHidden = true
    }
    
}

//MARK: - ReportDayDelegate
extension AddBudgetViewController: ReportDayDelegate {
    func changeReportDay(date: Date) {
        reportDay = date
    }
}

//MARK: - ReportDayDelegate
extension AddBudgetViewController: SettingCellDelegate {
    func openCurrencyChoose() {
        presenter?.chooseCurrency()
    }
}
