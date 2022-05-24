//
//  IncomeCollectionViewCell.swift
//  Finart
//
//  Created by Suren Kazaryan on 20.04.2022.
//

import UIKit

class IncomeCollectionViewCell: UICollectionViewCell {
    var delegate: CellDelegate?
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        //imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 10
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        //imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var spendingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    private lazy var planSpendingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        return button
    }()
    
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
    
    func update(name: String, account: Int, planAccount: Int, image: UIImage, currency: String) {
        let symbol = giveCurrencyVM(currency: currency).symbol
        if name == "AddButton20042022" {
            nameLabel.text = ""
            spendingLabel.text = ""
            planSpendingLabel.text = ""
            imageView.image = image.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal)
            imageView.layer.borderWidth = 0
        } else {
            nameLabel.text = name
            spendingLabel.text = "\(currencyFormat(number: account)) \(symbol)"
            planSpendingLabel.text = "\(currencyFormat(number: planAccount))"
            //imageView.image = image.withTintColor(.systemBackground, renderingMode: .alwaysOriginal)
            let newImage = image.withTintColor(.systemBackground, renderingMode: .alwaysOriginal)
            let resizedImage = resizeImage(image: newImage, targetSize: CGSize(width: frame.width, height: frame.height)) ?? .checkmark
            imageView.image = resizedImage
            imageView.backgroundColor = .systemGray

        }
    }
    
    func giveName() -> String {
        return nameLabel.text ?? ""
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
        layer.add(shakeAnimation, forKey: "shaking")
        
        deleteButton.isHidden = false
    }

    func stopShaking() {
        let layer: CALayer = self.layer
        layer.removeAnimation(forKey: "shaking")
        
        deleteButton.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.layer.borderWidth = 1
        imageView.backgroundColor = .none
        imageView.layer.borderWidth = 0
    }
    
}

//MARK: - Private methods
extension IncomeCollectionViewCell {
    private func setupCell() {
      //  contentView.backgroundColor = .green

        contentView.addSubviews(views: [
            nameLabel,
            imageView,
            spendingLabel,
            planSpendingLabel
        ])
        
        contentView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.15),
            
            imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            spendingLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3),
            spendingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            spendingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            spendingLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.15),
            
            planSpendingLabel.topAnchor.constraint(equalTo: spendingLabel.bottomAnchor, constant: 1),
            planSpendingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            planSpendingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            planSpendingLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.13),
            
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            deleteButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            deleteButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            
        ])
        
    }
    
    @objc private func deletePressed() {
        delegate?.delete(cell: self)
    }
    
}


