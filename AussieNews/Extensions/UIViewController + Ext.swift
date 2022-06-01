//
//  UIViewController + Ext.swift
//  AussieNews
//
//  Created by Alexander Thompson on 28/3/2022.
//

import UIKit
import SafariServices

extension UIViewController {

    ///Sets any previously saved Dark Mode status from UserDefaults.
    func selectCurrentDarkMode() {
        let defaults = UserDefaults.standard
        var mode     = traitCollection.userInterfaceStyle

        switch defaults.object(forKey: DarkMode.key) as? String {
        case DarkMode.device: mode = UIScreen.main.traitCollection.userInterfaceStyle
        case DarkMode.light:  mode = UIUserInterfaceStyle.light
        case DarkMode.dark:   mode = UIUserInterfaceStyle.dark
        case nil:             mode = UIScreen.main.traitCollection.userInterfaceStyle
        default:              mode = UIScreen.main.traitCollection.userInterfaceStyle
        }
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = mode
        }
    }

    func showArticle(_ vc: UIViewController, article: Article) {
        UserDefaultFuncs().saveArticle(.visited, article: article)
        guard let articleLink = article.link else { return }
        if let url = URL(string: articleLink) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let safariVC = SFSafariViewController(url: url, configuration: config)
            vc.present(safariVC, animated: true)
        }
    }

    enum saveStatus {
        case saving
        case removing
        case copied
    }

    func saveLabel(_ status: saveStatus) {
        let toastView = ToastView()

        switch status {
        case .saving:
            toastView.set(image: Images.bookMarkFill!, mainText: SaveLabelText.saveMain, secondText: SaveLabelText.saveSecond)
        case .removing:
            toastView.set(image: Images.bookmark!, mainText: SaveLabelText.removingMain, secondText: SaveLabelText.removingSecond)
        case .copied:
            toastView.set(image: Images.link!, mainText: SaveLabelText.copiedMain, secondText: SaveLabelText.copiedSecond)
        }
        
        self.view.addSubview(toastView)
        self.view.bringSubviewToFront(toastView)
        
        NSLayoutConstraint.activate([
            toastView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            toastView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            toastView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            toastView.heightAnchor.constraint(equalToConstant: 60),
        ])

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn) {
                toastView.alpha = 0.0
            } completion: { _ in
                toastView.removeFromSuperview()
            }
        }
    }
    
}
