//
//  UIView+Extensions.swift
//  Finart
//
//  Created by Suren Kazaryan on 13.04.2022.
//

import UIKit

extension UIView {
    func addSubviews(views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
