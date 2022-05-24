//
//  TransactionView.swift
//  Finart
//
//  Created by Suren Kazaryan on 20.04.2022.
//

import UIKit

class TransactionView: UIView {
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
extension TransactionView {
    private func setup() {
        
        addSubviews(views: [
            headerLabel,
            tfView,
            //countField,
            dataPicker,
        ])
        
        tfView.addSubview(countField)
        
        NSLayoutConstraint.activate([
            countField.topAnchor.constraint(equalTo: tfView.topAnchor),
            countField.leadingAnchor.constraint(equalTo: tfView.leadingAnchor, constant: 10),
            countField.trailingAnchor.constraint(equalTo: tfView.trailingAnchor, constant: -10),
            countField.bottomAnchor.constraint(equalTo: tfView.bottomAnchor),
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
