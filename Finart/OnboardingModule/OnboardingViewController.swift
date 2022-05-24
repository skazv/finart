//
//  OnboardingViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 21.04.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    let onboardingView = OnboardingView()
    
    override func loadView() {
        super.loadView()
        view = onboardingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
