//
//  ViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 17/3/2022.
//

import UIKit
import SafariServices


//to do next - get all network parameters working with topics
//finish design of trending and add gestures & button
//build .map algorithm to filter out identical headlines
//rework getNews to create new array when selecting collection view

//    var uniqueArticles: [Article] = []
//    for article in newsArticles {
//        if !newsArticles.contains(where: {$0.topic == article.topic }) {
//            uniqueArticles.append(article)
//        }
//    }
//


class HomeVC: UIViewController {
    
    //MARK: - Caruables & Constants
    
    
    var collectionView: UICollectionView!
    var newsArticles: [Article] = []
    
    let tableView        = UITableView()
    let topicArray       = ["sport", "tech", "finance", "politics", "business", "economics", "entertainment", "beauty"]
    let userDefaultFuncs = UserDefaultFuncs()
    let tableViewRefresh = UIRefreshControl()
    let generator = UIImpactFeedbackGenerator(style: .light)
    var sizeBool: Bool = true
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaultFuncs.retrievePages()
        configureVC()
        configureCollectionView()
        configureTableView()
        configureBarButton()
        layoutUI()
        getArticles(params: .home)
    }

    
    //MARK: - Funcs
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Home"
        
       
        generator.prepare()
    }
    
    
    func configureBarButton() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchPressed))
        let switchCellButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(switchCellButtonPressed))
        navigationItem.rightBarButtonItems = [searchButton, switchCellButton]
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
    
    
    @objc func refreshStarted() {
        newsArticles.removeAll()
        getArticles(params: .home)
        generator.impactOccurred()
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.collectionViewLayout(in: view))
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
    
    
    func getArticles(params: NewsManager.networkParams) {
        NewsManager.Shared.getNews(params: params) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let newsArticles):
                DispatchQueue.main.async {
                    self.newsArticles.append(contentsOf: newsArticles.articles)
                    self.tableView.reloadData()
                    print(self.newsArticles.count)
                }
                
            case.failure(let error): print(error.rawValue)
            }
        }
        self.tableViewRefresh.endRefreshing()
    }
    
    //reduce to one func 
    func showArticle(urlString: String) {
        if let url = URL(string: urlString) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    
    @objc func searchPressed() {
        let vc = SearchVC()
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        self.present(vc, animated: true)
    }
    
    
    //move back to cell as multiple pages will use this
    @objc func saveButtonPressed(sender: CustomButton) {
        
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: self.tableView)
        guard let indexPath = self.tableView.indexPathForRow(at: buttonPosition) else { return }
        
        let article = newsArticles[indexPath.row]
        
        switch UserDefaultFuncs.savedPagesArray.contains(article) {
        case true: UserDefaultFuncs().removeSavedPage(article: article)
            self.saveLabel(.removing)
        case false: UserDefaultFuncs().savePages(.saved, article: article)
            self.saveLabel(.saving)
        }
        tableView.reloadData()
        print(UserDefaultFuncs.savedPagesArray.count)
    }
    
    @objc func switchCellButtonPressed() {
        sizeBool.toggle()
        tableView.reloadData()
        tableView.reloadInputViews()
    }
    
    }


//MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = newsArticles[indexPath.row]
        
        switch sizeBool {
        case true: let cell = tableView.dequeueReusableCell(withIdentifier: bigHomeCell.reuseIdentifier) as! bigHomeCell
            cell.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
            cell.set(article: article)
            return cell
        case false: let cell = tableView.dequeueReusableCell(withIdentifier: smallHomeCell.reuseIdentifier) as! smallHomeCell
            cell.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
            cell.set(article: article)
            return cell
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sizeBool {
        case true: return view.frame.size.height / 2.8
        case false: return view.frame.size.height / 6
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = newsArticles[indexPath.row]
        userDefaultFuncs.savePages(.visited, article: article)
        showArticle(urlString: article.link!)
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
        NewsManager.Shared.topic = topic
        let vc = TrendingCategoryVC()
        vc.title = topic
        show(vc, sender: self)
    }
}



