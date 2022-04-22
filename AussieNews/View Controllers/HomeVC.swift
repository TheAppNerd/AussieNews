//
//  ViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 17/3/2022.
//

import UIKit

class HomeVC: CustomViewController, SafariProtocol {
    
    // TODO: remove all !
    
    //MARK: - View Funcs
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        selectCurrentDarkMode()
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureBarButton()
        configureCollectionView()
        configureTableView(vc: self)
        layoutUI()
        configureTableViewRefresh()
        getArticles(params: .home)
    }
    
    
    //MARK: - Funcs
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Home" // TODO: Change this to Aussie News Logo
        generator.prepare()
    }
    
    
    func configureTableViewRefresh() {
        tableView.refreshControl = tableViewRefresh
        tableViewRefresh.addTarget(self, action: #selector(refreshStarted), for: .valueChanged)
    }
    
    ///Sets any previously saved Dark Mode status from UserDefaults.
    private func selectCurrentDarkMode() {
        let defaults = UserDefaults.standard
        var mode = traitCollection.userInterfaceStyle
        
        switch defaults.object(forKey: "darkMode") as? String {
        case "Device": mode = UIScreen.main.traitCollection.userInterfaceStyle
        case "Light":  mode = UIUserInterfaceStyle.light
        case "Dark":   mode = UIUserInterfaceStyle.dark
        case nil:      mode = UIScreen.main.traitCollection.userInterfaceStyle
        default:       mode = UIScreen.main.traitCollection.userInterfaceStyle
        }
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = mode
        }
    }
    
    ///When tableViewRefresh is activated this clears all new articles and reloads a new array of articles.
    @objc func refreshStarted() {
        newsArticles.removeAll()
        getArticles(params: .home)
        generator.impactOccurred()
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout.collectionViewLayout(in: view, items: 4))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        collectionView.isScrollEnabled = true
        collectionView.delegate        = self
        collectionView.dataSource      = self
    }
    
    
    func layoutUI() {
        view.addSubviews(collectionView, tableView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.width / 4),

            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


//MARK: - TableView - UITableViewDelegate, UITableViewDataSource

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = newsArticles[indexPath.row]
        let cell = bigSmallCell(article: article)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = newsArticles[indexPath.row]
        showArticle(self, article: article)
    }
}

//MARK: - CollectionView - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topics.allCases.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
        let topic = topics.allCases[indexPath.item]
        cell.set(topic: topic.rawValue)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TrendingCategoryVC()
        vc.modalPresentationStyle = .popover
        vc.topic = topics.allCases[indexPath.row].rawValue
        present(vc, animated: true)
    }
}


