//
//  ProfileProtocols.swift
//  Finart
//
//  Created by Suren Kazaryan on 01.05.2022.
//

import UIKit

protocol ProfileDelegate: AnyObject {
}

protocol ProfileViewProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }

    // PRESENTER -> VIEW
}

protocol ProfilePresenterProtocol: AnyObject {
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    var router: ProfileRouterProtocol? { get set }
    //var delegate: ProfileDelegate? { get set }
    
    // VIEW -> PRESENTER
    func openSettings()
}

protocol ProfileRouterProtocol: AnyObject {
    //static func createProfileModul(with delegate: ProfileDelegate) -> UIViewController
    static func createProfileModul() -> UIViewController
    
    // PRESENTER -> ROUTER
    func presentSettingsScreen(from view: ProfileViewProtocol)
    func dismissProfile(from view: ProfileViewProtocol, completion: (() -> Void)?)
}

protocol ProfileInteractorInputProtocol: AnyObject {
    var presenter: ProfileInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol ProfileInteractorOutputProtocol: AnyObject {
}
