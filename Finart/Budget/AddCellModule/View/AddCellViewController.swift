//
//  AddCellViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 23.04.2022.
//

import UIKit

class AddCellViewController: UIViewController {
    let addCellView = AddCellView()
    var presenter: AddCellPresenterProtocol?
    var iconName: String?
    var currencyName: String?
    
    override func loadView() {
        super.loadView()
        view = addCellView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationItems()
        hideKeyboardWhenTappedAround()
    }
    
}

//MARK: - Private methods
extension AddCellViewController {
    private func setup() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(iconTapped))
        addCellView.iconImageView.addGestureRecognizer(gesture)
        
        let currencyGesture = UITapGestureRecognizer(target: self, action: #selector(currencyTapped))
        addCellView.chooseCurrencyLabel.addGestureRecognizer(currencyGesture)
        
        guard let cellType = presenter?.cellType else { return }
        guard let currency = presenter?.currency else { return }
        let currencyVM = giveCurrencyVM(currency: currency)
        addCellView.chooseCurrencyLabel.text = currencyVM.symbol
        currencyName = currencyVM.shortName
        
        switch cellType {
        case .income:
            addCellView.updateAdd(title: "Добавить доход", support: "Ежемесячный план")
        case .account:
            addCellView.updateAdd(title: "Добавить баланс", support: "Текущий баланс")
        case .spending:
            addCellView.updateAdd(title: "Добавить расход", support: "Ежемесячный план")
        }
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
        guard let name = addCellView.titleTextField.text, addCellView.titleTextField.text != "" else {
            showAlarm(navigation: self, title: "Ошибка", message: "Введите название")
            return
        }
        guard let currency = currencyName else { return }
        let count = Int(addCellView.countTextField.text ?? "0") ?? 0
        presenter?.addCell(name: name, count: count, icon: imageName, currency: currency)
    }
    
    @objc private func iconTapped() {
        presenter?.chooseIcon()
    }
    
    @objc private func currencyTapped() {
        presenter?.chooseCurrency()
    }
}


//MARK: - AddCellViewProtocol
extension AddCellViewController: AddCellViewProtocol {
    func didChooseCurrency(currencyName: String) {
        self.currencyName = currencyName
        let currency = giveCurrencyVM(currency: currencyName)
        addCellView.chooseCurrencyLabel.text = currency.symbol
    }
    
    func didChooseImage(iconName: String) {
        self.iconName = iconName
        addCellView.iconImageView.image = UIImage(systemName: iconName)
        addCellView.chooseIconLabel.isHidden = true
    }
    
}
