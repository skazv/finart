//
//  ProfileRouter.swift
//  Finart
//
//  Created by Suren Kazaryan on 01.05.2022.
//

import UIKit

class ProfileRouter: ProfileRouterProtocol {
    static func createProfileModul() -> UIViewController {
        let viewController = ProfileViewController()
           let presenter: ProfilePresenterProtocol & ProfileInteractorOutputProtocol = ProfilePresenter()
           let router: ProfileRouterProtocol = ProfileRouter()
           let interactor: ProfileInteractorInputProtocol = ProfileInteractor()
   
           viewController.presenter = presenter
           presenter.view = viewController
           presenter.router = router
           presenter.interactor = interactor
           interactor.presenter = presenter
   
           return viewController
    }
    
    
//    static func createProfileModul(with delegate: ProfileDelegate) -> UIViewController {
//        let viewController = ProfileViewController()
//        let presenter: ProfilePresenterProtocol & ProfileInteractorOutputProtocol = ProfilePresenter()
//        let router: ProfileRouterProtocol = ProfileRouter()
//        let interactor: ProfileInteractorInputProtocol = ProfileInteractor()
//
//        viewController.presenter = presenter
//        presenter.view = viewController
//        presenter.router = router
//        presenter.interactor = interactor
//        presenter.delegate = delegate
//        interactor.presenter = presenter
//
//        return viewController
//    }
    
    func dismissProfile(from view: ProfileViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
    func presentSettingsScreen(from view: ProfileViewProtocol) {
        guard let delegate = view.presenter as? SettingsDelegate else { return }
//        let settingsVC = UINavigationController(rootViewController: SettingsRouter.createSettingsModul(with: delegate))

        let settingsVC = SettingsRouter.createSettingsModul(with: delegate)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }

        viewVC.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
}
