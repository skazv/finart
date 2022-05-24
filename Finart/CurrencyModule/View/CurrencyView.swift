//
//  CurrencyView.swift
//  Finart
//
//  Created by Suren Kazaryan on 16.05.2022.
//

import UIKit

class CurrencyView: UIView {
    
    lazy var currencyTableView: UITableView = {
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
    
}

//MARK: - Private methods
extension CurrencyView {
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        
        addSubviews(views: [
            currencyTableView,
        ])
        NSLayoutConstraint.activate([
            currencyTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            currencyTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            currencyTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            currencyTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
}
