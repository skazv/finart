//
//  UpdateCellView.swift
//  Finart
//
//  Created by Suren Kazaryan on 28.04.2022.
//

import UIKit

class UpdateCellView: UIView {
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Добавить"
        label.textAlignment = .center
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 0.5
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()

    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите название"
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
        textField.rightViewMode = .always
        textField.rightView = supportCountLabel
        textField.keyboardType = .numberPad
        return textField
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        func updateView(title: String, count: String, image: UIImage) {
            titleTextField.text = title
            countTextField.text = count
            iconImageView.image = image
        }
    
    func updateAdd(title: String, support: String) {
        headerLabel.text = title
        supportCountLabel.text = support
    }
    
}

//MARK: - Private methods
extension UpdateCellView {
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        
        addSubviews(views: [
            headerLabel,
            iconImageView,
            titleTextField,
            separatorLineView,
            countTextField,
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


        ])
    }
    
}


//class UpdateCellView: UIView {
//
//    lazy var iconImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "circle")
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.isUserInteractionEnabled = true
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
//
//    lazy var titleTextField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.placeholder = "Введите название"
//        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "circle")
//        textField.rightViewMode = .always
//        textField.rightView = imageView
//        return textField
//    }()
//
//    lazy var countTextField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.placeholder = "Введите сумму"
//        let label = UILabel()
//        label.text = "в месяц"
//        label.textColor = .secondaryLabel
//        textField.rightViewMode = .always
//        textField.rightView = label
//        //textField.keyboardType = .numberPad
//        return textField
//    }()
//
//    init() {
//        super.init(frame: .zero)
//        setupView()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func updateView(title: String, count: String, image: UIImage) {
//        titleTextField.placeholder = title
//        countTextField.placeholder = count
//        iconImageView.image = image
//    }
//
//}
//
////MARK: - Private methods
//extension UpdateCellView {
//    private func setupView() {
//        backgroundColor = .secondarySystemBackground
//
//        addSubviews(views: [
//            iconImageView,
//            titleTextField,
//            countTextField,
//        ])
//
//
//        NSLayoutConstraint.activate([
//
//            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            iconImageView.bottomAnchor.constraint(equalTo: titleTextField.topAnchor),
//            iconImageView.widthAnchor.constraint(equalToConstant: 80),
//            iconImageView.heightAnchor.constraint(equalToConstant: 80),
//
//            titleTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
//            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//
//            countTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 5),
//            countTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            countTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//
//        ])
//    }
//}
