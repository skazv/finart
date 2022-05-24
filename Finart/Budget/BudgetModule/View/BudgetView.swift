//
//  BudgetView.swift
//  Finart
//
//  Created by Suren Kazaryan on 20.04.2022.
//

import UIKit

class BudgetView: UIView {
    let incomeView = IncomeCollectionView()
    let accountView = AccountCollectionView()
    let spendView = SpendingCollectionView()
    
    lazy var selectBudgetTableButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Название ⌵", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    private lazy var topBackgorundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
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
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(budgetName: String) {
        selectBudgetTableButton.setTitle("\(budgetName) ⌵", for: .normal)
    }
    
}

//MARK: - Private methods
extension BudgetView {
    private func setup() {
        addSubviews(views: [
            topBackgorundView,
            incomeView,
            accountView,
            spendView
        ])
    
        topBackgorundView.addSubview(topView)
        
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
            topBackgorundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topBackgorundView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            topBackgorundView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            topBackgorundView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            
            topView.topAnchor.constraint(equalTo: topBackgorundView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: topBackgorundView.leadingAnchor, constant: 8),
            topView.trailingAnchor.constraint(equalTo: topBackgorundView.trailingAnchor, constant: -8),
            topView.bottomAnchor.constraint(equalTo: topBackgorundView.bottomAnchor),
            
            incomeView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 8),
            incomeView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            incomeView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            incomeView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.15),
            
            accountView.topAnchor.constraint(equalTo: incomeView.bottomAnchor, constant: 8),
            accountView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            accountView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            accountView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.15),
            
            spendView.topAnchor.constraint(equalTo: accountView.bottomAnchor, constant: 8),
            spendView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            spendView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            spendView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
    
}
