//
//  ViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 17/3/2022.
//

import UIKit

class HomeVC: CustomViewController, SafariProtocol {
    
 
    var collectionView: UICollectionView!
    
   // let tableViewRefresh = UIRefreshControl()
    let generator = UIImpactFeedbackGenerator(style: .light)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        selectCurrentDarkMode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureCollectionView()
        configureTableView()
        configureBarButton()
        layoutUI()
        getArticles(params: .home)
        //initLoadingPage()
    }

    
    //MARK: - Funcs
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Home"
        
       
        generator.prepare()
    }
    
    
   
    
    
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(bigHomeCell.self, forCellReuseIdentifier: bigHomeCell.reuseIdentifier)
        tableView.register(smallHomeCell.self, forCellReuseIdentifier: smallHomeCell.reuseIdentifier)
        tableView.delegate       = self
        tableView.dataSource     = self
        tableView.refreshControl = tableViewRefresh
        tableViewRefresh.addTarget(self, action: #selector(refreshStarted), for: .valueChanged)
      
    }
    
    func initLoadingPage() {
        
        let loadingPageView = LoadingPageView()
        view.addSubview(loadingPageView)
        view.bringSubviewToFront(loadingPageView)
        
        NSLayoutConstraint.activate([
            loadingPageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingPageView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingPageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingPageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            loadingPageView.removeFromSuperview()
            print("done")
        }
            
        
    }
    
    private func selectCurrentDarkMode() {
        let defaults = UserDefaults.standard
        var mode = traitCollection.userInterfaceStyle
        
        switch defaults.object(forKey: "darkMode") as? String {
        case "Device": mode = UIScreen.main.traitCollection.userInterfaceStyle
        case "Light": mode = UIUserInterfaceStyle.light
        case "Dark": mode = UIUserInterfaceStyle.dark
        case nil: mode = UIScreen.main.traitCollection.userInterfaceStyle
        default:
            mode = UIScreen.main.traitCollection.userInterfaceStyle
        }
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = mode
        }
}
    
    
    @objc func refreshStarted() {
        //newsArticles.removeAll()
        //getArticles(params: .home)
        generator.impactOccurred()
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.collectionViewLayout(in: view, items: 4))
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
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    
    
    }


//MARK: - UITableViewDelegate, UITableViewDataSource

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

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
        let topic = topicArray[indexPath.item]
            cell.set(topic: topic)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topic = topicArray[indexPath.row]
        
        let vc = TrendingCategoryVC()
        vc.title = topic
        vc.topic = topic
        show(vc, sender: self)
    }
}


