//
//  AddCellView.swift
//  Finart
//
//  Created by Suren Kazaryan on 23.04.2022.
//

import UIKit

class AddCellView: UIView {
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Добавить"
        label.textAlignment = .center
        return label
    }()
    
//    private lazy var currencyImageView: UIImageView = {
//        let button = UIImageView(image: IconLib.rub.image)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    lazy var chooseCurrencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
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
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(systemName: "app")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 0.5
        imageView.backgroundColor = .secondarySystemBackground
        //.systemBackground
        return imageView
    }()
    
//    lazy var colorImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "circle")
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.isUserInteractionEnabled = true
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()

    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите название"
        //        let imageView = UIImageView()
        //        imageView.image = UIImage(systemName: "circle")
        //        textField.rightViewMode = .always
        //        textField.rightView = imageView
        return textField
    }()
    
    private lazy var supportCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.text = "атрибут"
        return label
    }()
    
    private lazy var separatorLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    lazy var countTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите сумму"
        //let label = UILabel()
        //label.text = "в месяц"
        //label.textColor = .secondaryLabel
        textField.rightViewMode = .always
        textField.rightView = supportCountLabel
        textField.keyboardType = .numberPad
        return textField
    }()
    
//    lazy var switcher: UISwitch = {
//        let switcher = UISwitch()
//        switcher.translatesAutoresizingMaskIntoConstraints = false
//        return switcher
//    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateAdd(title: String, support: String) {
        headerLabel.text = title
        supportCountLabel.text = support
    }
    
}

//MARK: - Private methods
extension AddCellView {
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        
        addSubviews(views: [
            headerLabel,
            iconImageView,
            chooseCurrencyLabel,
         //   colorImageView,
         //   currencyButton,
            titleTextField,
            separatorLineView,
            countTextField,
          //  switcher,
        ])
        
        iconImageView.addSubview(chooseIconLabel)
        
        NSLayoutConstraint.activate([
            chooseIconLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor, constant: 15),
            chooseIconLabel.leadingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: 15),
            chooseIconLabel.trailingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: -15),
            chooseIconLabel.bottomAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: -15),
        ])
        
        NSLayoutConstraint.activate([
            
            headerLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            headerLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),

            iconImageView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            iconImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),

            chooseCurrencyLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            chooseCurrencyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            chooseCurrencyLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            chooseCurrencyLabel.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),

            
//            currencyButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
//            currencyButton.trailingAnchor.constraint(equalTo: trailingAnchor),
//            currencyButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
//            currencyButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            
//            colorImageView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
//            colorImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            colorImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
//            colorImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            
            titleTextField.topAnchor.constraint(equalTo: iconImageView.bottomAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
            
            separatorLineView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor),
            separatorLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            separatorLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            separatorLineView.heightAnchor.constraint(equalToConstant: 1),
            
            countTextField.topAnchor.constraint(equalTo: separatorLineView.bottomAnchor),
            countTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            countTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            countTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
            
//            switcher.topAnchor.constraint(equalTo: countTextField.bottomAnchor),
//            switcher.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            switcher.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            switcher.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),

        ])
    }
    
}
