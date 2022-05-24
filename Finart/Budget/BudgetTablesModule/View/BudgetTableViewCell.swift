//
//  BudgetTableViewCell.swift
//  Finart
//
//  Created by Suren Kazaryan on 08.05.2022.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {
    var delegate: UpdateBudgetCellDelegate?
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var chooseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .checkmark
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
    
    lazy var editButtom: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "pencil.circle")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(name: String, image: UIImage, isCurrent: Bool) {
        nameLabel.text = name
        iconImageView.image = image
        if isCurrent {
            chooseImageView.alpha = 1
        } else {
            chooseImageView.alpha = 0
        }
        //countLabel.text = "\(count)"
    }
    
}

//MARK: - Private methods
extension BudgetTableViewCell {
    private func setup() {
      //  backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(cardView)
        
        cardView.addSubviews(views: [
            iconImageView,
            nameLabel,
            editButtom,
            chooseImageView,
            //countLabel,
        ])
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            
            iconImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5),
            iconImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            iconImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
        
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 5),
            nameLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            
            editButtom.topAnchor.constraint(equalTo: cardView.topAnchor),
            editButtom.trailingAnchor.constraint(equalTo: chooseImageView.leadingAnchor, constant: -15),
            editButtom.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            
            chooseImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            chooseImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            chooseImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            chooseImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
//            countLabel.topAnchor.constraint(equalTo: cardView.topAnchor),
//            countLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
//            countLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            
        ])
    }
    
    @objc private func editTapped() {
        delegate?.updateCell(cell: self)
    }
    
}

