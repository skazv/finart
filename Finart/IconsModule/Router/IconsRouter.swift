//
//  IconsRouter.swift
//  Finart
//
//  Created by Suren Kazaryan on 24.04.2022.
//

import UIKit

class IconsRouter: IconsRouterProtocol {
    static func createIconsModul(with delegate: IconsDelegate) -> UIViewController {
        let viewController = IconsViewController()
        let presenter: IconsPresenterProtocol & IconsInteractorOutputProtocol = IconsPresenter()
        let router: IconsRouterProtocol = IconsRouter()
        let interactor: IconsInteractorInputProtocol = IconsInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return viewController
    }
    
    func dismissIcons(from view: IconsViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
