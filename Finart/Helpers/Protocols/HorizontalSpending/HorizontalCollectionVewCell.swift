//
//  HorizontalVewCell.swift
//  Finart
//
//  Created by Suren Kazaryan on 17.04.2022.
//

import UIKit

class HorizontalCollectionVewCell: UICollectionViewCell {
    let spendingCollectionView = SpendingCollectionView()
    
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
extension HorizontalCollectionVewCell {
    private func setupCell() {
        contentView.addSubview(spendingCollectionView)
        
        NSLayoutConstraint.activate([
            spendingCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            spendingCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            spendingCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            spendingCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
}

