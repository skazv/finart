//
//  HorizontalCollectionView.swift
//  Finart
//
//  Created by Suren Kazaryan on 17.04.2022.
//

import UIKit

class HorizontalCollectionView: UICollectionView {
    let customCellId = "accountCell"
    let layout = UICollectionViewFlowLayout()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension HorizontalCollectionView {
    private func setup() {
        layout.scrollDirection = .horizontal
        
        decelerationRate = .fast
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        register(HorizontalCollectionVewCell.self, forCellWithReuseIdentifier: customCellId)
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        dataSource = self
        delegate = self
    }
    
}

//MARK: - UICollectionViewDataSource
extension HorizontalCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath) as? HorizontalCollectionVewCell else { return UICollectionViewCell() }
        return cell
    }

}

//MARK: - UICollectionViewDelegateFlowLayout
extension HorizontalCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

}

//MARK: - UICollectionViewDelegate
extension HorizontalCollectionView: UICollectionViewDelegate {
}
