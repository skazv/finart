//
//  AccountCollectionViewCell.swift
//  Finart
//
//  Created by Suren Kazaryan on 17.04.2022.
//

import UIKit

class AccountCollectionViewCell: UICollectionViewCell {
    var accountCellDelegate: AccountCellDelegate?

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Кошелек"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.text = "10 000 $"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        return button
    }()
    
    func update(name: String, count: Int, image: UIImage, currency: String) {
        let symbol = giveCurrencyVM(currency: currency).symbol
        if name == "AddButton20042022" {
            //MARK: - ОЧЕНЬ ПЛОХО
            //ICON
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = image.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal)
            imageAttachment.bounds = CGRect(x: 0, y: 0, width: contentView.frame.width - 10, height: contentView.frame.height - 10)
            let attachmentString:NSAttributedString = NSAttributedString(attachment: imageAttachment)
            let myString:NSMutableAttributedString = NSMutableAttributedString(string: "")
            myString.append(attachmentString)
            countLabel.textAlignment = .center
            countLabel.attributedText = myString
            //ICON
            
            nameLabel.text = ""
            contentView.backgroundColor = .secondarySystemBackground
            imageView.layer.borderWidth = 0
        } else {
            nameLabel.text = name
            nameLabel.textColor = .systemBackground
            countLabel.text = "\(currencyFormat(number: count)) \(symbol)"
            countLabel.textColor = .systemBackground
            imageView.image = image.withTintColor(.systemBackground, renderingMode: .alwaysOriginal)
            imageView.isHidden = false
            contentView.backgroundColor = .systemBrown
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupCell()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shake() {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
        shakeAnimation.duration = 0.05
        shakeAnimation.repeatCount = 2
        shakeAnimation.autoreverses = true
        let startAngle: Float = (-2) * 3.14159/180
        let stopAngle = -startAngle
        shakeAnimation.fromValue = NSNumber(value: startAngle as Float)
        shakeAnimation.toValue = NSNumber(value: 3 * stopAngle as Float)
        shakeAnimation.autoreverses = true
        shakeAnimation.duration = 0.15
        shakeAnimation.repeatCount = 10000
        shakeAnimation.timeOffset = 290 * drand48()

        let layer: CALayer = self.layer
        layer.add(shakeAnimation, forKey:"shaking")
        
        deleteButton.isHidden = false
    }

    func stopShaking() {
        let layer: CALayer = self.layer
        layer.removeAnimation(forKey: "shaking")
        
        deleteButton.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = .systemBackground
        countLabel.font = .boldSystemFont(ofSize: 18)
        imageView.isHidden = true
        alpha = 0
    }
    
}

//MARK: - Private methods
extension AccountCollectionViewCell {
    private func setupCell() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        
        contentView.addSubviews(views: [
            nameLabel,
            imageView,
            countLabel,
            deleteButton
        ])
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            countLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            deleteButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            deleteButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            
        ])
        
    }
    
    @objc private func deletePressed() {
        accountCellDelegate?.delete(cell: self)
    }
    
}

