//
//  IconsView.swift
//  Finart
//
//  Created by Suren Kazaryan on 23.04.2022.
//

import UIKit

class IconsCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        //imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBackground
        return imageView
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
    
    func putImage(image: UIImage) {
        imageView.image = image
    }
    
}

//MARK: - Private methods
extension IconsCollectionViewCell {
    private func setupCell() {
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

        ])
        
    }
    
}

