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
        UITabBar.appearance().backgroundColor = . systemGray2
        UITabBar.appearance().tintColor = .darkGray
        viewControllers = [createHomeScreenVC(), createCategoriesVC(), createSavedVC(), createSettingsVC()]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .green
    }
    
    
    func createHomeScreenVC() -> UINavigationController {
        let homeVC = HomeVC()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        return UINavigationController(rootViewController: homeVC)
    }
    
    func createCategoriesVC() -> UINavigationController {
        let categoriesVC = CategoriesVC()
        categoriesVC.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "square.grid.2x2"), selectedImage: UIImage(systemName: "square.grid.2x2.fill"))
        return UINavigationController(rootViewController: categoriesVC)
    }
    
    
    func createSavedVC() -> UINavigationController {
        let savedVC = SavedVC()
        savedVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"))
        return UINavigationController(rootViewController: savedVC)
    }
    
    func createSettingsVC() -> UINavigationController {
        let settingsVC = SettingsVC()
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        return UINavigationController(rootViewController: settingsVC)
    }
    
    
}
