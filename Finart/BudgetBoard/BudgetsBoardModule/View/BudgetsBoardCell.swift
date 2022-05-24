//
//  BudgetsBoardCell.swift
//  Finart
//
//  Created by Suren Kazaryan on 09.05.2022.
//

import Foundation
import UIKit

class BudgetsBoardCell: UICollectionViewCell {
    var accountCellDelegate: AccountCellDelegate?

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Кошелек"
        label.numberOfLines = 2
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
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        //view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    private lazy var incomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Доход"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    lazy var incomeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "120000 ₽"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.textColor = .systemGreen
        return label
    }()
    
    lazy var incomePlanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "140000"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Баланс"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    lazy var accountValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "250000 ₽"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    lazy var accountPlanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+24%"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var spendingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Расходы"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    lazy var spendingValuewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "54000 ₽"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.textColor = .systemRed
        return label
    }()
    
    lazy var spendingPlanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "80000"
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
    
    func update(name: String, count: Int, image: UIImage) {
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
            countLabel.text = "\(currencyFormat(number: count)) $"
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
extension BudgetsBoardCell {
    private func setupCell() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        
        contentView.addSubviews(views: [
            nameLabel,
            imageView,
          //  countLabel,
            topView,
            deleteButton,
        ])
        
        topView.addSubviews(views: [
            incomeLabel,
            incomeValueLabel,
            incomePlanLabel,
            accountLabel,
            accountValueLabel,
            accountPlanLabel,
            spendingLabel,
            spendingValuewLabel,
            spendingPlanLabel,
        ])
        
        NSLayoutConstraint.activate([
            accountLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 5),
            accountLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            accountLabel.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.3),
            accountLabel.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.3),

            accountValueLabel.topAnchor.constraint(equalTo: accountLabel.bottomAnchor, constant: 5),
            accountValueLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            accountValueLabel.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.3),
            accountValueLabel.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.25),
            
            accountPlanLabel.topAnchor.constraint(equalTo: accountValueLabel.bottomAnchor),
            accountPlanLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            accountPlanLabel.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.3),
            accountPlanLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8),
            
            //INCOME
            incomeLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 5),
            incomeLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            incomeLabel.trailingAnchor.constraint(equalTo: accountLabel.leadingAnchor),
            incomeLabel.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.3),
            
            incomeValueLabel.topAnchor.constraint(equalTo: incomeLabel.bottomAnchor, constant: 5),
            incomeValueLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            incomeValueLabel.trailingAnchor.constraint(equalTo: accountLabel.leadingAnchor),
            incomeValueLabel.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.25),

            incomePlanLabel.topAnchor.constraint(equalTo: incomeValueLabel.bottomAnchor),
            incomePlanLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            incomePlanLabel.trailingAnchor.constraint(equalTo: accountLabel.leadingAnchor),
            incomePlanLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8),
            
            //SPENDING
            spendingLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 5),
            spendingLabel.leadingAnchor.constraint(equalTo: accountLabel.trailingAnchor),
            spendingLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            spendingLabel.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.3),
            
            spendingValuewLabel.topAnchor.constraint(equalTo: spendingLabel.bottomAnchor, constant: 5),
            spendingValuewLabel.leadingAnchor.constraint(equalTo: accountLabel.trailingAnchor),
            spendingValuewLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            spendingValuewLabel.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.25),
            
            spendingPlanLabel.topAnchor.constraint(equalTo: spendingValuewLabel.bottomAnchor),
            spendingPlanLabel.leadingAnchor.constraint(equalTo: accountLabel.trailingAnchor),
            spendingPlanLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            spendingPlanLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            nameLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
//            countLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
//            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
      
            topView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            topView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            deleteButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            deleteButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            
        ])
        
    }
    
    @objc private func deletePressed() {
       // accountCellDelegate?.delete(cell: self)
    }
    
}

