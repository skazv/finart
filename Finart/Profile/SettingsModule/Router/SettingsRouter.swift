//
//  SettingsRouter.swift
//  Finart
//
//  Created by Suren Kazaryan on 02.05.2022.
//

import UIKit

class SettingsRouter: SettingsRouterProtocol {
    static func createSettingsModul(with delegate: SettingsDelegate) -> UIViewController {
        let viewController = SettingsViewController()
        let presenter: SettingsPresenterProtocol & SettingsInteractorOutputProtocol = SettingsPresenter()
        let router: SettingsRouterProtocol = SettingsRouter()
        let interactor: SettingsInteractorInputProtocol = SettingsInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return viewController
    }
    
    func dismissSettings(from view: SettingsViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
