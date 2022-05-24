//
//  SettingsView.swift
//  Finart
//
//  Created by Suren Kazaryan on 02.05.2022.
//

import UIKit

class SettingsView: UIView {
    
    lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .secondarySystemBackground
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension SettingsView {
    private func setupView() {
        //backgroundColor = .secondarySystemBackground
        
      //  let date = Date()
        //print(date)
        let days = UserDefaultsManager.getDaysUserDefaults()
//        print(UserDefaultsManager.getDaysUserDefaults())
        days.forEach { day in
            print("day: \(day)")
        }
        
        addSubviews(views: [
            settingsTableView,
        ])
        
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
}
