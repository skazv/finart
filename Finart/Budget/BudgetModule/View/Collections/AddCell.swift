//
//  AddCell.swift
//  Finart
//
//  Created by Suren Kazaryan on 15.05.2022.
//

import UIKit

class AddCell: UICollectionViewCell {
    
    private lazy var voidView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        //imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 10
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
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
    
    func updateImage(image: UIImage) {
        imageView.image = image.withTintColor(.systemGray5, renderingMode: .alwaysOriginal)
    }
    
}

//MARK: - Private methods
extension AddCell {
    private func setupCell() {
      //  contentView.backgroundColor = .green

        contentView.addSubviews(views: [
            voidView,
            imageView,
        ])
                
        NSLayoutConstraint.activate([
            
            voidView.topAnchor.constraint(equalTo: contentView.topAnchor),
            voidView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            voidView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            voidView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.15),
            
            imageView.topAnchor.constraint(equalTo: voidView.bottomAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
        ])
        
    }
    
}
