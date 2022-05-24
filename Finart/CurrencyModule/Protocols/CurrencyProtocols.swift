//
//  CurrencyProtocols.swift
//  Finart
//
//  Created by Suren Kazaryan on 16.05.2022.
//

import UIKit

protocol CurrencyDelegate: AnyObject {
    func didChooseCurrency(currencyName: String)
}

protocol CurrencyViewProtocol: AnyObject {
    var presenter: CurrencyPresenterProtocol? { get set }

    // PRESENTER -> VIEW
}

protocol CurrencyPresenterProtocol: AnyObject {
    var view: CurrencyViewProtocol? { get set }
    var interactor: CurrencyInteractorInputProtocol? { get set }
    var router: CurrencyRouterProtocol? { get set }
    var delegate: CurrencyDelegate? { get set }
    
    // VIEW -> PRESENTER
}

protocol CurrencyRouterProtocol: AnyObject {
    static func createCurrencyModul(with delegate: CurrencyDelegate) -> UIViewController
    
    // PRESENTER -> ROUTER
    func dismissCurrency(from view: CurrencyViewProtocol, completion: (() -> Void)?)
}

protocol CurrencyInteractorInputProtocol: AnyObject {
    var presenter: CurrencyInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol CurrencyInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}
