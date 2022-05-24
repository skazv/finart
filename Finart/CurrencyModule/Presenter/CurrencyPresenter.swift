//
//  CurrencyPresenter.swift
//  Finart
//
//  Created by Suren Kazaryan on 16.05.2022.
//

import Foundation

class CurrencyPresenter: CurrencyPresenterProtocol {
    var view: CurrencyViewProtocol?
    var interactor: CurrencyInteractorInputProtocol?
    var router: CurrencyRouterProtocol?
    var delegate: CurrencyDelegate?
    
}

//MARK: - CurrencyInteractorOutputProtocol
extension CurrencyPresenter: CurrencyInteractorOutputProtocol {
    
}

