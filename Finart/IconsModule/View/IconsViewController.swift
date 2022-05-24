//
//  IconsViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 23.04.2022.
//

import UIKit

class IconsViewController: UIViewController {
    var presenter: IconsPresenterProtocol?
    let iconsCollectionView = IconsCollectionView()
    
    override func loadView() {
        super.loadView()
        view = iconsCollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

//MARK: - Private methods
extension IconsViewController {
    private func setup() {
        iconsCollectionView.iconCallback = { [weak self] iconName in
            guard let self = self else { return }
            self.presenter?.delegate?.didChooseIcon(iconName: iconName)
            self.presenter?.router?.dismissIcons(from: self, completion: nil)
        }
    }
}


//MARK: - IconsViewProtocol
extension IconsViewController: IconsViewProtocol {
}
