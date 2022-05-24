//
//  SettingTableViewCell.swift
//  Finart
//
//  Created by Suren Kazaryan on 02.05.2022.
//

import Foundation
import UIKit

class SettingsViewCell: UITableViewCell {
    var delegate: SettingCellDelegate?
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.text = "Name"
        return label
    }()
    
    lazy var currencyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.text = "Американский доллар"
        return label
    }()
    
    lazy var currencySymbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.text = "$"
        return label
    }()
    
    lazy var chooseCurrencyImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(systemName: "circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 0.5
        imageView.backgroundColor = .secondarySystemBackground
        let gesture = UITapGestureRecognizer(target: self, action: #selector(currencyTapped))
        imageView.addGestureRecognizer(gesture)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCurrency() {
        //currencySymbolLabel.text = s
    }
    
}

//MARK: - Private methods
extension SettingsViewCell {
    private func setup() {
        backgroundColor = .systemBackground
        
        contentView.addSubviews(views: [
            iconImageView,
            nameLabel,
            //chooseCurrencyImageView,
            currencyNameLabel,
            currencySymbolLabel,
            //countLabel,
        ])
                
        NSLayoutConstraint.activate([
            
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            iconImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
        
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            currencyNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            currencyNameLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            currencyNameLabel.trailingAnchor.constraint(equalTo: currencySymbolLabel.leadingAnchor, constant: -10),
            currencyNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            currencySymbolLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            currencySymbolLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            currencySymbolLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            currencySymbolLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1),
            
//            chooseCurrencyImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            chooseCurrencyImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            chooseCurrencyImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
//            chooseCurrencyImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            
//            countLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
//            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
    @objc private func currencyTapped() {
        delegate?.openCurrencyChoose()
    }
    
}

