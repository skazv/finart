//
//  AddBudgetView.swift
//  Finart
//
//  Created by Suren Kazaryan on 08.05.2022.
//

import UIKit

class AddBudgetView: UIView {
    
    lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .secondarySystemBackground
        return tableView
    }()
    
//    private lazy var currencyButton: UIImageView = {
//        let button = UIImageView(image: IconLib.rub.image)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(systemName: "circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 0.5
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    lazy var chooseIconLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Выбрать иконку"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()

    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите название"
        return textField
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
extension AddBudgetView {
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        addSubviews(views: [
            iconImageView,
            titleTextField,
         //   currencyButton,
            settingsTableView,
        ])
        
        iconImageView.addSubview(chooseIconLabel)
        
        NSLayoutConstraint.activate([
            chooseIconLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor, constant: 15),
            chooseIconLabel.leadingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: 15),
            chooseIconLabel.trailingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: -15),
            chooseIconLabel.bottomAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: -15),
        ])
        
        NSLayoutConstraint.activate([

            iconImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            iconImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            iconImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            iconImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            
            titleTextField.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            titleTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
            
//            currencyButton.topAnchor.constraint(equalTo: iconImageView.bottomAnchor),
//            currencyButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            currencyButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
//            currencyButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            
            settingsTableView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

        ])
        
    }
}
