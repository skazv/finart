//
//  ProfilePresenter.swift
//  Finart
//
//  Created by Suren Kazaryan on 01.05.2022.
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol {
    var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var router: ProfileRouterProtocol?
    var delegate: ProfileDelegate?
    
    func openSettings() {
        guard let view = view else { return }
        router?.presentSettingsScreen(from: view)
    }
    
}

//MARK: - ProfileInteractorOutputProtocol
extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
}

//MARK: - SettingsDelegate
extension ProfilePresenter: SettingsDelegate {

}
