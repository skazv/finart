//
//  SettingsProtocols.swift
//  Finart
//
//  Created by Suren Kazaryan on 02.05.2022.
//

import UIKit

protocol SettingsDelegate: AnyObject {
}

protocol SettingsViewProtocol: AnyObject {
    var presenter: SettingsPresenterProtocol? { get set }

    // PRESENTER -> VIEW
    func reloadReportDay(date: Date)
}

protocol SettingsPresenterProtocol: AnyObject {
    var view: SettingsViewProtocol? { get set }
    var interactor: SettingsInteractorInputProtocol? { get set }
    var router: SettingsRouterProtocol? { get set }
    var delegate: SettingsDelegate? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func changeReportDay(date: Date)
}

protocol SettingsRouterProtocol: AnyObject {
    static func createSettingsModul(with delegate: SettingsDelegate) -> UIViewController
    
    // PRESENTER -> ROUTER
    func dismissSettings(from view: SettingsViewProtocol, completion: (() -> Void)?)
}

protocol SettingsInteractorInputProtocol: AnyObject {
    var presenter: SettingsInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func changeReportDay(date: Date)
    func fetchReportDate()
}

protocol SettingsInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func didFetchReportDay(date: Date)
}
