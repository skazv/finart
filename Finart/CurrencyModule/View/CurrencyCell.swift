//
//  CurrencyCell.swift
//  Finart
//
//  Created by Suren Kazaryan on 16.05.2022.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = .boldSystemFont(ofSize: 16)
        label.font = .italicSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.text = "Американский доллар"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        //label.textAlignment = .center
        return label
    }()
    
    private lazy var shortNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
       // label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        label.text = "USD"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .right
        return label
    }()
    
    private lazy var currencySymbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.text = "$"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
//    lazy var countLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .boldSystemFont(ofSize: 14)
//        label.numberOfLines = 1
//        label.text = "1000"
//        return label
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(name: String, shortName: String, currencySymbol: String, isCurrent: Bool) {
        nameLabel.text = name
        shortNameLabel.text = shortName
        currencySymbolLabel.text = currencySymbol
    }
    
}

//MARK: - Private methods
extension CurrencyCell {
    private func setup() {
      //  backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(cardView)
        
        cardView.addSubviews(views: [
            nameLabel,
            shortNameLabel,
            currencySymbolLabel,
        ])
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([

            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5),
            nameLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            nameLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.6),
            
            shortNameLabel.topAnchor.constraint(equalTo: cardView.topAnchor),
            shortNameLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            shortNameLabel.trailingAnchor.constraint(equalTo: currencySymbolLabel.leadingAnchor, constant: -15),
            shortNameLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            
            currencySymbolLabel.topAnchor.constraint(equalTo: cardView.topAnchor),
            currencySymbolLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            currencySymbolLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            currencySymbolLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.1),
                        
        ])
    }
    
}

