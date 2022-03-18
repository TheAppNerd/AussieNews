//
//  TabBarController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 17/3/2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       UITabBar.appearance().tintColor = .green
       viewControllers = [createHomeScreenVC(), createSecondVC()]
    }
    
    
    func createHomeScreenVC() -> UINavigationController {
        let homeVC = HomeScreenViewController()
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    func createSecondVC() -> UINavigationController {
        let secondVC = SeconfViewController()
        secondVC.title = "second"
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        return UINavigationController(rootViewController: secondVC)
    }
    

}
