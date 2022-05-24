//
//  NetworkCore.swift
//  Finart
//
//  Created by Suren Kazaryan on 22.05.2022.
//

import Foundation

protocol Responsable: Codable {
    
}

typealias CoreResult<T: Responsable> = Swift.Result<T, NetworkError>

protocol NetworkCoreProtocol {
    func request<Res: Responsable>(metadata: String, completion: @escaping (CoreResult<Res>) -> Void)
}

struct NetworkCore {
    static let shared: NetworkCoreProtocol = NetworkCore()
    let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 3
        config.timeoutIntervalForResource = 3
        session = URLSession(configuration: config)
    }
    
    private let url = "https://cdn.cur.su/api/cbr.json"
    private let jsonDecoder = JSONDecoder()
}

//MARK: - NetworkCoreProtocol
extension NetworkCore: NetworkCoreProtocol {
    func request<Res>(metadata: String, completion: @escaping (CoreResult<Res>) -> Void) where Res : Responsable {
        let requestUrl = URL(string: "\(url)/\(metadata)")
        guard let url = requestUrl else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }

        let dataTask = session.dataTask(with: url, completionHandler:  { data, response, error in
                if let data = data,
                   (response as? HTTPURLResponse)?.statusCode == 200,
                   error == nil {
                    self.handleSuccessDataRespones(data, completion: completion)
                } else {
                    print(NetworkError.handleDataResponesError)
                    completion(.failure(.noInternet))
                }
            })
        dataTask.resume()
    }
    
}

//MARK: - Private methods
extension NetworkCore {
    private func handleSuccessDataRespones<Res: Responsable>(_ data: Data, completion: (CoreResult<Res>) -> Void) {
        do {
            completion(.success(try decodeData(data: data)))
        } catch {
            completion(.failure(.responseDecodingError))
        }
    }
    
    private func decodeData<Res: Responsable>(data: Data) throws -> Res {
        let respones = try jsonDecoder.decode(Res.self, from: data)
        return respones
    }
}
