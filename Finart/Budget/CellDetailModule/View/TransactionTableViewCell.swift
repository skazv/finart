//
//  TransactionTableViewCell.swift
//  Finart
//
//  Created by Suren Kazaryan on 29.04.2022.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
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
        label.text = "Name"
        //label.textAlignment = .center
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.text = "1000"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension TransactionTableViewCell {
    private func setup() {
        self.backgroundColor = .secondarySystemBackground
        
        contentView.addSubviews(views: [
            iconImageView,
            nameLabel,
            countLabel,
        ])
                
        NSLayoutConstraint.activate([
            
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            iconImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
        
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            countLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
}

