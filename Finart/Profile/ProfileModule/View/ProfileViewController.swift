//
//  ProfileViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 01.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    let profileView = ProfileView()
    var presenter: ProfilePresenterProtocol?
    
    override func loadView() {
        super.loadView()
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

//MARK: - Private methods
extension ProfileViewController {
    private func setup() {
        navigationItem.title = "Profile"
        
        let setupImage = UIImage(systemName: IconLib.gearshape.rawValue)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: setupImage, landscapeImagePhone: nil, style: .done, target: self, action: #selector(setupTapped))
        
    }
    
    @objc private func setupTapped() {
        presenter?.openSettings()
    }
    
}


//MARK: - ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
}
