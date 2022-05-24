//
//  UserModel.swift
//  Finart
//
//  Created by Suren Kazaryan on 02.05.2022.
//

import Foundation

struct UserModel {
    var isFirstLoad: Bool
    var reportDate: Date
    var newReportMounth: Date
    var newReportYear: Date
    var reportDay: Date
}

enum UserDefaultsKeys: String {
    case budget
    case reportDay
    case reportDate
    case newReportMounth
    case newReportYear
    case isSecondLoad
}


