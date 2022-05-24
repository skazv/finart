//
//  CellDetailView.swift
//  Finart
//
//  Created by Suren Kazaryan on 26.04.2022.
//

import UIKit

class CellDetailView: UIView {
    
    private lazy var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0$"
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    lazy var editButtom: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "pencil.circle")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private lazy var operationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Транзакции"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(title: String, count: String, image: UIImage) {
        titleLabel.text = title
        countLabel.text = count
        iconImageView.image = image
    }
    
}

//MARK: - Private methods
extension CellDetailView {
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        
        addSubview(cellView)
        
        cellView.addSubviews(views: [
            iconImageView,
            titleLabel,
            countLabel,
            //editButtom,
        ])
        
        addSubview(operationsLabel)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([

            cellView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            cellView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            cellView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.08),
            
            iconImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalTo: cellView.heightAnchor, multiplier: 0.9),
            iconImageView.heightAnchor.constraint(equalTo: cellView.heightAnchor, multiplier: 0.9),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: cellView.widthAnchor, multiplier: 0.3),
            titleLabel.heightAnchor.constraint(equalTo: cellView.heightAnchor, multiplier: 0.8),
            
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            countLabel.widthAnchor.constraint(greaterThanOrEqualTo: cellView.widthAnchor, multiplier: 0.3),
            //countLabel.trailingAnchor.constraint(equalTo: editButtom.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            countLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            countLabel.heightAnchor.constraint(equalTo: cellView.heightAnchor, multiplier: 0.8),
            
//            editButtom.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
//            editButtom.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
//            editButtom.widthAnchor.constraint(equalTo: cellView.heightAnchor, multiplier: 0.4),
//            editButtom.heightAnchor.constraint(equalTo: cellView.heightAnchor, multiplier: 0.4),
            
            operationsLabel.topAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 20),
            operationsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            operationsLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            operationsLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.02),
            
            tableView.topAnchor.constraint(equalTo: operationsLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
        ])
        
    }
}
