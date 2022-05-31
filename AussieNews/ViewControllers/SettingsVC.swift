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

    //MARK: - Class Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableview()
        selectCurrentDarkModeSettings()
    }

    //MARK: - Methods

    private func configure() {
        view.backgroundColor          = .secondarySystemBackground
       title = "Settings"
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

    /// Automatically sets segmented controller to whatever saved dark mode setting is.
    private func selectCurrentDarkModeSettings() {
        let defaults = UserDefaults.standard
        switch defaults.object(forKey: DarkMode.key) as? String {
        case DarkMode.device: darkModeSegment = 0
        case DarkMode.light: darkModeSegment  = 1
        case DarkMode.dark: darkModeSegment   = 2
        case nil: darkModeSegment             = 0
        default:
            darkModeSegment                   = 0
        }
        tableView.reloadSections([0,0], with: .none)
    }

    /// Open relevent social media links.
    func openSocialMedia(urlString: String) {
        let urlStr = urlString
        guard let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }

    // MARK: - @objc funcs

    /// Changes dark mode setting across the app based on users choice.
    @objc func segmentChanged(sender: UISegmentedControl) {
        var mode      = traitCollection.userInterfaceStyle
        let defaults  = UserDefaults.standard

        switch sender.selectedSegmentIndex {
        case 0: mode  = UIScreen.main.traitCollection.userInterfaceStyle
                        defaults.set(DarkMode.device, forKey: DarkMode.key)
        case 1: mode  = UIUserInterfaceStyle.light
                        defaults.set(DarkMode.light, forKey: DarkMode.key)
        case 2: mode  = UIUserInterfaceStyle.dark
                        defaults.set(DarkMode.dark, forKey: DarkMode.key)
        default: mode = UITraitCollection.current.userInterfaceStyle
        }
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = mode
        }
    }

}

// MARK: - TableView - UITableViewDelegate, UITableViewDataSource

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
            cell.set(image: SocialMedia.socialImageArray[indexPath.row], text: SocialMedia.socialTextArray[indexPath.row])
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
        case [1,1]: openSocialMedia(urlString: SocialMedia.websiteURL)
        case [1,2]: openSocialMedia(urlString: SocialMedia.githubURL)
        case [1,3]: openSocialMedia(urlString: SocialMedia.linkedInURL)
        case [1,4]: openSocialMedia(urlString: SocialMedia.instagramURL)
        default:
            print("")
        }
    }

}
