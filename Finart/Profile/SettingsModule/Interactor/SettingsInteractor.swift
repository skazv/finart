//
//  SettingsInteractor.swift
//  Finart
//
//  Created by Suren Kazaryan on 02.05.2022.
//

import Foundation

class SettingsInteractor: SettingsInteractorInputProtocol {
    var presenter: SettingsInteractorOutputProtocol?
    
    func fetchReportDate() {
        let date = UserDefaultsManager.getDateUserDefaults()
        presenter?.didFetchReportDay(date: date)
    }
    
    func changeReportDay(date: Date) {
        UserDefaultsManager.saveDateUserDefaults(date: date)
        presenter?.didFetchReportDay(date: date)
    }
    
}
