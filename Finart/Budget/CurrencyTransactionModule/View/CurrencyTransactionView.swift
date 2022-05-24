//
//  CurrencyTransactionView.swift
//  Finart
//
//  Created by Suren Kazaryan on 19.05.2022.
//

import UIKit

class CurrencyTransactionView: UIView {
    var delegate: TransactionViewDelegate?
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Add cell"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tfView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    lazy var supportCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray3
        label.font = .boldSystemFont(ofSize: 30)
        label.text = "$"
        return label
    }()
    
    lazy var secondSupportCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray3
        label.font = .boldSystemFont(ofSize: 30)
        label.text = "$"
        return label
    }()

    lazy var countField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .systemBackground
        tf.layer.cornerRadius = 12
        tf.placeholder = "0"
        tf.textColor = .systemGray
        tf.tintColor = .systemGray
        tf.keyboardType = .asciiCapableNumberPad
        tf.font = .boldSystemFont(ofSize: 30)
        tf.adjustsFontSizeToFitWidth = true
        tf.minimumFontSize = 0.5
        tf.minimumContentSizeCategory = .extraLarge
        tf.textAlignment = .right
        tf.rightViewMode = .always
        tf.rightView = supportCountLabel
        return tf
    }()
    
    private lazy var separatorLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.systemGray2.cgColor //UIColor.black.cgColor
        return view
    }()
    
    lazy var secondCountField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .systemBackground
        tf.layer.cornerRadius = 12
        tf.placeholder = "0"
        tf.textColor = .systemGray
        tf.tintColor = .systemGray
        tf.keyboardType = .asciiCapableNumberPad
        tf.font = .boldSystemFont(ofSize: 30)
        tf.adjustsFontSizeToFitWidth = true
        tf.minimumFontSize = 0.5
        tf.minimumContentSizeCategory = .extraLarge
        tf.textAlignment = .right
        tf.rightViewMode = .always
        tf.rightView = secondSupportCountLabel
        return tf
    }()
    
    lazy var dataPicker: UIDatePicker = {
        let dataPicker = UIDatePicker()
        dataPicker.translatesAutoresizingMaskIntoConstraints = false
        dataPicker.datePickerMode = .date
        dataPicker.timeZone = .current
        dataPicker.addTarget(self, action: #selector(datePicked), for: .valueChanged)
        dataPicker.tintAdjustmentMode = .automatic
        dataPicker.minimumContentSizeCategory = .accessibilityMedium
        return dataPicker
    }()
    
    private lazy var keyboardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        return view
    }()
    
    init(){
        super.init(frame: .zero)
        setup()
    }

    func update(name: String) {
        headerLabel.text = name
        //nameField.placeholder = "fromt: \(from) To \(to)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension CurrencyTransactionView {
    private func setup() {
        
        addSubviews(views: [
            headerLabel,
            tfView,
            //countField,
            dataPicker,
        ])
        
        //tfView.addSubview(countField)
        tfView.addSubviews(views: [
            countField,
            separatorLineView,
            secondCountField,
        ])
        
        NSLayoutConstraint.activate([
            countField.topAnchor.constraint(equalTo: tfView.topAnchor),
            countField.leadingAnchor.constraint(equalTo: tfView.leadingAnchor, constant: 10),
            countField.widthAnchor.constraint(equalTo: tfView.widthAnchor, multiplier: 0.4),
            countField.bottomAnchor.constraint(equalTo: tfView.bottomAnchor),
            
            separatorLineView.heightAnchor.constraint(equalTo: tfView.heightAnchor),
            separatorLineView.widthAnchor.constraint(equalToConstant: 1),
            separatorLineView.centerXAnchor.constraint(equalTo: tfView.centerXAnchor),
            separatorLineView.centerYAnchor.constraint(equalTo: tfView.centerYAnchor),
            
            secondCountField.topAnchor.constraint(equalTo: tfView.topAnchor),
            secondCountField.widthAnchor.constraint(equalTo: tfView.widthAnchor, multiplier: 0.4),
            secondCountField.trailingAnchor.constraint(equalTo: tfView.trailingAnchor, constant: -10),
            secondCountField.bottomAnchor.constraint(equalTo: tfView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            
            headerLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
            
            tfView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            tfView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tfView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tfView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),

//            countField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
//            countField.leadingAnchor.constraint(equalTo: leadingAnchor),
//            countField.trailingAnchor.constraint(equalTo: trailingAnchor),
//            countField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),

            dataPicker.topAnchor.constraint(equalTo: countField.bottomAnchor, constant: 8),
            dataPicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            dataPicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            dataPicker.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05)
            
        ])
                
    }
    
    @objc private func datePicked(sender: UIDatePicker) {
        var date = sender.date
        date.addTimeInterval(60*60*3) // УЖАСНО
        delegate?.changeDate(date: date)
    }
    
}
