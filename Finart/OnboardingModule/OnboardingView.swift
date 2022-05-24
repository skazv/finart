//
//  OnboardingView.swift
//  Finart
//
//  Created by Suren Kazaryan on 21.04.2022.
//

import UIKit

class OnboardingView: UIView {

    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Полный учет расходов и доходов"
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    
    private lazy var helpImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension OnboardingView {
    private func setup() {
        backgroundColor = .systemBackground
        
        addSubviews(views: [
            mainLabel,
        ])
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            mainLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
        ])
        
    }
}
