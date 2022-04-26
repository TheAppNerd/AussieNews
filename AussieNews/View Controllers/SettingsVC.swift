//
//  SettingsVC.swift
//  AussieNews
//
//  Created by Alexander Thompson on 21/3/2022.
//

import UIKit

class SettingsVC: UIViewController {
    
    
    //MARK: - Properties
    
    var tableView = UITableView()
    var darkModeSegment: Int = 0
    
    //MARK: - View Funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableview()
        selectCurrentDarkMode()
    }
    
    //MARK: - Functions
    
    private func configure() {
        view.backgroundColor          = .secondarySystemBackground
        let icon                      = UIImage(named: "aussieNewsIcon")
        let iconImageView             = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        iconImageView.contentMode     = .scaleAspectFit
        iconImageView.image           = icon
        self.navigationItem.titleView = iconImageView
    }
    
    
    private func configureTableview() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SettingsSegmentCell.self, forCellReuseIdentifier: SettingsSegmentCell.reuseIdentifier)
        tableView.register(SettingsSocialCell.self, forCellReuseIdentifier: SettingsSocialCell.reuseIdentifier)
        tableView.backgroundColor     = .secondarySystemBackground
        tableView.dataSource          = self
        tableView.delegate            = self
        tableView.backgroundColor     = .secondarySystemBackground
        tableView.layer.cornerRadius  = 10
        tableView.layer.masksToBounds = true
        tableView.tableFooterView     = SettingsFooterView()
        
        view.addSubview(tableView)
    }
    
    ///Automatically sets segmented controller to whatever saved dark mode setting is.
    private func selectCurrentDarkMode() {
        let defaults = UserDefaults.standard
        switch defaults.object(forKey: darkMode.key) as? String {
        case darkMode.device: darkModeSegment = 0
        case darkMode.light: darkModeSegment  = 1
        case darkMode.dark: darkModeSegment   = 2
        case nil: darkModeSegment             = 0
        default:
            darkModeSegment                   = 0
        }
        tableView.reloadSections([0,0], with: .none)
    }
    
    ///Open relevent social media links.
    func openSocialMedia(urlString: String) {
        let urlStr = urlString
        guard let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    
    //MARK: - @objc funcs
    
    ///Changes dark mode setting across the app based on users choice.
    @objc func segmentChanged(sender: UISegmentedControl) {
        var mode      = traitCollection.userInterfaceStyle
        let defaults  = UserDefaults.standard
        
        switch sender.selectedSegmentIndex {
        case 0: mode  = UIScreen.main.traitCollection.userInterfaceStyle
                        defaults.set(darkMode.device, forKey: darkMode.key)
        case 1: mode  = UIUserInterfaceStyle.light
                        defaults.set(darkMode.light, forKey: darkMode.key)
        case 2: mode  = UIUserInterfaceStyle.dark
                        defaults.set(darkMode.dark, forKey: darkMode.key)
        default: mode = UITraitCollection.current.userInterfaceStyle
        }
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = mode
        }
    }
    
}

//MARK: - TableView - UITableViewDelegate, UITableViewDataSource

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:  return 1
        case 1:  return 5
        default: return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        } else {
            return 30
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "APPEARANCE"
        }
        return " "
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:  let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSegmentCell.reuseIdentifier, for: indexPath) as! SettingsSegmentCell
            cell.darkModeSegment.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
            cell.darkModeSegment.selectedSegmentIndex = darkModeSegment
            return cell
            
        case 1:  let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSocialCell.reuseIdentifier, for: indexPath) as! SettingsSocialCell
            cell.set(image: cell.imageArray[indexPath.row], text: cell.textArray[indexPath.row])
            cell.accessoryType = .disclosureIndicator
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSocialCell.reuseIdentifier, for: indexPath)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [1,0]: EmailFeedback().newEmail()
        case [1,1]: openSocialMedia(urlString: socialMedia.websiteURL)
        case [1,2]: openSocialMedia(urlString: socialMedia.githubURL)
        case [1,3]: openSocialMedia(urlString: socialMedia.linkedInURL)
        case [1,4]: openSocialMedia(urlString: socialMedia.instagramURL)
        default:
            print("")
        }
        
    }
    
    
    
    
}
