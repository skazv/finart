//
//  fff.swift
//  Finart
//
//  Created by Suren Kazaryan on 17.04.2022.
//

import UIKit

class HorizontalIncomeCollectionViewCell: UICollectionViewCell {
    let incomeCollectionView = IncomeCollectionView()
    
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
    
}

//MARK: - Private methods
extension HorizontalIncomeCollectionViewCell {
    private func setupCell() {
        contentView.addSubview(incomeCollectionView)

        NSLayoutConstraint.activate([
            incomeCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            incomeCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            incomeCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            incomeCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
}


