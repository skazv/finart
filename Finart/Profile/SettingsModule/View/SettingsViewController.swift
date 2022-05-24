//
//  SettingsViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 02.05.2022.
//

import UIKit

protocol ReportDayDelegate {
    func changeReportDay(date: Date)
}

class SettingsViewController: UIViewController {
    let settingsView = SettingsView()
    var presenter: SettingsPresenterProtocol?
    let settingsArray: [SettignsSection] = [
        SettignsSection(name: "Основные", settingsCell: [
            SettignsCell(icon: IconLib.calendar.image, name: "Отчетный период"),
            SettignsCell(icon: IconLib.reportFirstDay.image, name: "Дата начала"),
            SettignsCell(icon: IconLib.person.image, name: "Язык"),
            SettignsCell(icon: IconLib.banknote.image, name: "Валюта"),
        ]),
        SettignsSection(name: "Оформление", settingsCell: [
            SettignsCell(icon: IconLib.backgroundColor.image, name: "Цвет фона"),
            SettignsCell(icon: IconLib.cellColor.image, name: "Цвет иконок"),
        ])
    ]
    
    var reportDay: Date?
    
    override func loadView() {
        super.loadView()
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setup()
    }
    
}

//MARK: - Private methods
extension SettingsViewController {
    private func setup() {
        settingsView.settingsTableView.register(SettingsViewCell.self, forCellReuseIdentifier: "settings")
        settingsView.settingsTableView.register(DataPickerViewCell.self, forCellReuseIdentifier: "data")
        settingsView.settingsTableView.dataSource = self
        settingsView.settingsTableView.delegate = self
    }
}


//MARK: - SettingsViewProtocol
extension SettingsViewController: SettingsViewProtocol {
    
    //ПУСТО!
    func reloadReportDay(date: Date) {
    }
    
}


//MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
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
        if indexPath.row == 1 && indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "data", for: indexPath) as? DataPickerViewCell else { return UITableViewCell() }
            cell.nameLabel.text = settingsArray[indexPath.section].settingsCell[indexPath.row].name
            cell.iconImageView.image = settingsArray[indexPath.section].settingsCell[indexPath.row].icon
            cell.dataPicker.date = UserDefaultsManager.getDateUserDefaults() //Плохо!!!
            cell.delegate = self
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath) as? SettingsViewCell else { return UITableViewCell() }
            cell.nameLabel.text = settingsArray[indexPath.section].settingsCell[indexPath.row].name
            cell.iconImageView.image = settingsArray[indexPath.section].settingsCell[indexPath.row].icon
            return cell
        }
    }
    
}

//MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.frame.height / 15
        return height
    }
    
}

//MARK: - UserSettingsDelegate
extension SettingsViewController: ReportDayDelegate {
    
    func changeReportDay(date: Date) {
        presenter?.changeReportDay(date: date)
    }
    
}
