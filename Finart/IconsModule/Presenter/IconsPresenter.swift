//
//  IconsPresenter.swift
//  Finart
//
//  Created by Suren Kazaryan on 24.04.2022.
//

import Foundation

class IconsPresenter: IconsPresenterProtocol {
    var view: IconsViewProtocol?
    var interactor: IconsInteractorInputProtocol?
    var router: IconsRouterProtocol?
    var delegate: IconsDelegate?
    
}

extension IconsPresenter: IconsInteractorOutputProtocol {
    
}

