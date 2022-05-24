//
//  SettingsPresenter.swift
//  Finart
//
//  Created by Suren Kazaryan on 02.05.2022.
//

import Foundation

class SettingsPresenter: SettingsPresenterProtocol {
    var view: SettingsViewProtocol?
    var interactor: SettingsInteractorInputProtocol?
    var router: SettingsRouterProtocol?
    var delegate: SettingsDelegate?
    
    func viewDidLoad() {
        interactor?.fetchReportDate()
    }
    
    func changeReportDay(date: Date) {
        interactor?.changeReportDay(date: date)
    }
    
}

//MARK: - SettingsInteractorOutputProtocol
extension SettingsPresenter: SettingsInteractorOutputProtocol {
    func didFetchReportDay(date: Date) {
        view?.reloadReportDay(date: date)
    }
    
    
}

