//
//  IconsProtocols.swift
//  Finart
//
//  Created by Suren Kazaryan on 24.04.2022.
//

import UIKit

protocol IconsDelegate: AnyObject {
    func didChooseIcon(iconName: String)
}

protocol IconsViewProtocol: AnyObject {
    var presenter: IconsPresenterProtocol? { get set }

    // PRESENTER -> VIEW
}

protocol IconsPresenterProtocol: AnyObject {
    var view: IconsViewProtocol? { get set }
    var interactor: IconsInteractorInputProtocol? { get set }
    var router: IconsRouterProtocol? { get set }
    var delegate: IconsDelegate? { get set }
    
    // VIEW -> PRESENTER
}

protocol IconsRouterProtocol: AnyObject {
    static func createIconsModul(with delegate: IconsDelegate) -> UIViewController
    
    // PRESENTER -> ROUTER
    func dismissIcons(from view: IconsViewProtocol, completion: (() -> Void)?)
}

protocol IconsInteractorInputProtocol: AnyObject {
    var presenter: IconsInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol IconsInteractorOutputProtocol: AnyObject {
}
