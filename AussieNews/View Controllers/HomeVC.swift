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

class HomeVC: UIViewController {

    var collectionView: UICollectionView!
    let tableView = UITableView()
    var newsArticles: [Article] = []
    let topicArray = ["sport", "tech", "finance", "politics", "business", "economics", "entertainment", "beauty"]
    
//    var uniqueArticles: [Article] = []
//    for article in newsArticles {
//        if !newsArticles.contains(where: {$0.topic == article.topic }) {
//            uniqueArticles.append(article)
//        }
//    }
//    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureCollectionView()
        configureTableView()
        configureBarButton()
        layoutUI()
        getArticles()
    }

    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Home"
    }
    
    func configureBarButton() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchPressed))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: HomeScreenTableViewCell.reuseIdentifier)
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.collectionViewLayout(in: view))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
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
    
    func getArticles() {
        NewsManager.Shared.topic = "entertainment"
        NewsManager.Shared.getNews(params: .trending) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let newsArticles):
                DispatchQueue.main.async {
                    self.newsArticles.append(contentsOf: newsArticles.articles)
                    self.tableView.reloadData()
                }
                
            case.failure(let error): print(error.rawValue)
            }
        }
    }
    
    
    func showArticle(urlString: String) {
        if let url = URL(string: urlString) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    @objc func searchPressed() {
        print("search pressed")
        let vc = SearchVC()
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        self.present(vc, animated: true)
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeScreenTableViewCell.reuseIdentifier) as! HomeScreenTableViewCell
        
        
        
        let article = newsArticles[indexPath.row]
        cell.set(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let article = newsArticles[indexPath.row].link {
            showArticle(urlString: article)
        }
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
        let vc = TrendingCategoryVC()
       
        vc.set(articles: newsArticles)
        show(vc, sender: self)
    }
    

}



