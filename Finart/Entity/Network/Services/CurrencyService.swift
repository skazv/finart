//
//  CurrencyService.swift
//  Finart
//
//  Created by Suren Kazaryan on 22.05.2022.
//

import Foundation

protocol CurrencyServiceProtocol {
    func fetchCurrency(completion: @escaping (Swift.Result<CurrencyRaw, Error>) -> Void)
}

struct CurrencyService {
    private let network = NetworkCore.shared
}

extension CurrencyService: CurrencyServiceProtocol {
    func fetchCurrency(completion: @escaping (Result<CurrencyRaw, Error>) -> Void) {
        let metadata = ""
        network.request(metadata: metadata,
                        completion: { (result: CoreResult<CurrencyResponse>) in
            switch result {
            case .success(let response):
                completion(.success(response.rates.rates))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}
