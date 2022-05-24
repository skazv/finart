//
//  NetworkError.swift
//  Finart
//
//  Created by Suren Kazaryan on 22.05.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case handleDataResponesError
    case responseDecodingError
    case noInternet
    case fuckup
}
