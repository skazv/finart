//
//  BudgetTablesView.swift
//  Finart
//
//  Created by Suren Kazaryan on 05.05.2022.
//

import UIKit

class BudgetTablesView: UIView {
    
//    private lazy var currentBudgetView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .gray
//        return view
//    }()
//
//    private lazy var headerLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Текущий бюджет"
//        label.numberOfLines = 1
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.5
//        label.textAlignment = .center
//        return label
//    }()
//
//    private lazy var separatorLineView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.borderWidth = 1.0
//        view.layer.borderColor = UIColor.black.cgColor
//        return view
//    }()
//
//    private lazy var currentImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = 10
//        imageView.isUserInteractionEnabled = true
//        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = .red
//        return imageView
//    }()
//
//    private lazy var currentBudgetLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Budget name"
//        return label
//    }()
//
//    private lazy var choosenImageView: UIImageView = {
//        let image: UIImage = .checkmark
//        let imageView = UIImageView(image: image)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = 10
//        imageView.isUserInteractionEnabled = true
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.backgroundColor = .black
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
extension BudgetTablesView {
    private func setupView() {
        backgroundColor = .systemBackground
        
        addSubviews(views: [
        //    currentBudgetView,
            tableView,
        ])
        
//        currentBudgetView.addSubviews(views: [
//            headerLabel,
//            separatorLineView,
//            currentImageView,
//            currentBudgetLabel,
//            choosenImageView,
//        ])
        
        NSLayoutConstraint.activate([
//            currentBudgetView.topAnchor.constraint(equalTo: topAnchor),
//            currentBudgetView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            currentBudgetView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            currentBudgetView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
          //  tableView.topAnchor.constraint(equalTo: currentBudgetView.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
//        NSLayoutConstraint.activate([
//            headerLabel.topAnchor.constraint(equalTo: currentBudgetView.topAnchor, constant: 15),
//            headerLabel.leadingAnchor.constraint(equalTo: currentBudgetView.leadingAnchor),
//            headerLabel.trailingAnchor.constraint(equalTo: currentBudgetView.trailingAnchor),
//            headerLabel.heightAnchor.constraint(equalTo: currentBudgetView.heightAnchor, multiplier: 0.2),
//
//            separatorLineView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
//            separatorLineView.leadingAnchor.constraint(equalTo: currentBudgetView.leadingAnchor, constant: 20),
//            separatorLineView.trailingAnchor.constraint(equalTo: currentBudgetView.trailingAnchor, constant: -20),
//            separatorLineView.heightAnchor.constraint(equalToConstant: 1),
//
//            currentImageView.topAnchor.constraint(equalTo: separatorLineView.bottomAnchor, constant: 18),
//            currentImageView.leadingAnchor.constraint(equalTo: currentBudgetView.leadingAnchor, constant: 8),
//            currentImageView.heightAnchor.constraint(equalTo: currentBudgetView.heightAnchor, multiplier: 0.4),
//            currentImageView.widthAnchor.constraint(equalTo: currentBudgetView.heightAnchor, multiplier: 0.4),
//
//            currentBudgetLabel.topAnchor.constraint(equalTo: separatorLineView.bottomAnchor, constant: 15),
//            currentBudgetLabel.leadingAnchor.constraint(equalTo: currentImageView.trailingAnchor, constant: 8),
//            currentBudgetLabel.trailingAnchor.constraint(equalTo: choosenImageView.leadingAnchor),
//            currentBudgetLabel.heightAnchor.constraint(equalTo: currentBudgetView.heightAnchor, multiplier: 0.4),
//
//            choosenImageView.centerYAnchor.constraint(equalTo: currentImageView.centerYAnchor),
//            choosenImageView.trailingAnchor.constraint(equalTo: currentBudgetView.trailingAnchor, constant: -8),
//            choosenImageView.heightAnchor.constraint(equalTo: currentBudgetView.heightAnchor, multiplier: 0.2),
//            choosenImageView.widthAnchor.constraint(equalTo: currentBudgetView.heightAnchor, multiplier: 0.2),
//        ])
        
    }
}
