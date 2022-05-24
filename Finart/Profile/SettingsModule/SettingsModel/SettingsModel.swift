//
//  SettingsModel.swift
//  Finart
//
//  Created by Suren Kazaryan on 02.05.2022.
//

import Foundation
import UIKit

struct SettignsSection {
    let name: String
    let settingsCell: [SettignsCell]
}

struct SettignsCell {
    let icon: UIImage
    let name: String
}
