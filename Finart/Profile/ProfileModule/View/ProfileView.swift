//
//  ProfileView.swift
//  Finart
//
//  Created by Suren Kazaryan on 01.05.2022.
//

import UIKit

class ProfileView: UIView {
    
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Доходы", "Баланс", "Расходы"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(valueChanged), for: UIControl.Event.valueChanged)
        return segmentedControl
    }()
    
    private lazy var segmentedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var redView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var yellowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var greenView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension ProfileView {
    private func setupView() {
        
        addSubviews(views: [
            segmentedControl,
            segmentedView,
        ])
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            segmentedControl.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05),
            
            segmentedView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            segmentedView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            segmentedView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            segmentedView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
    @objc private func valueChanged(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            segmentedView.backgroundColor = .red
            //segmentedView = redView
            print("0")
        case 1:
            segmentedView.backgroundColor = .yellow
            //segmentedView = yellowView
            print("1")
        case 2:
            segmentedView.backgroundColor = .green
            //segmentedView = greenView
            print("2")
        default:
            print("deafault error")
        }
    }
    
}
