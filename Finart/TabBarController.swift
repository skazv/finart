//
//  ViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 12.04.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

}

//MARK: - Private methods
extension TabBarController {
    private func setupTabBar() {
        view.backgroundColor = .secondarySystemBackground
        
        tabBar.backgroundColor = .systemBackground
        tabBar.layer.cornerRadius = 20
        
        let budgetModule = BudgetRouter.createBudgetModul()
        let budjetVC = createNavController(viewController: budgetModule,
                                           title: "Бюджет",
                                           iconFromLib: .squarGrid4x3)

        let profileModul = ProfileRouter.createProfileModul()
        let profileVC = createNavController(viewController:  profileModul,
                                            title: "Профиль",
                                            iconFromLib: .person)
        
        setViewControllers([budjetVC, profileVC], animated: true)
  
    }
    
    private func createNavController(viewController: UIViewController, title: String, iconFromLib: IconLib) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(systemName: iconFromLib.rawValue)
        return navigationController
    }
    
}
