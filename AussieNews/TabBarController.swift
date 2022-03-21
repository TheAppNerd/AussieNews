//
//  TabBarController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 17/3/2022.
//

import UIKit

class TabBarController: UITabBarController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().backgroundColor = . systemGray5
       UITabBar.appearance().tintColor = .green
       viewControllers = [createHomeScreenVC(), createSecondVC()]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .green
    }
    
    
    func createHomeScreenVC() -> UINavigationController {
        let homeVC = HomeVC()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    func createSecondVC() -> UINavigationController {
        let secondVC = SavedVC()
        secondVC.title = "Saved"
        secondVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "bookmark"), tag: 1)
        return UINavigationController(rootViewController: secondVC)
    }
    

}
