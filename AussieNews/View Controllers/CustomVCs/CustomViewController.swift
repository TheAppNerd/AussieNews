//
//  CustomeViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 29/3/2022.
//

import UIKit

class CustomViewController: UIViewController {
    
    //MARK: - Properties
    
    let tableView        = UITableView()
    let tableViewRefresh = UIRefreshControl()
    let generator        = UIImpactFeedbackGenerator(style: .light)
    let emptyStateView   = EmptyStateView()
    
    var sizeBool: Bool   = true
    var collectionView: UICollectionView!
    var newsArticles: [Article] = []
    
    
    //MARK: - Functions
    
    ///Parses the newsArticle data into the relevent tableview.
    func getArticles(params: NewsManager.networkParams) {
        NewsManager.Shared.getNews(params: params) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let newsArticles):
                DispatchQueue.main.async {
                    self.newsArticles.append(contentsOf: newsArticles.articles)
                    self.updateUI()
                }
            case.failure(let error): print(error.rawValue)
            }
        }
    }
    
    
    ///Update UI in event of successful network call.
    func updateUI() {
        tableView.reloadData()
        emptyStateView.removeFromSuperview()
        tableViewRefresh.endRefreshing()
        newsArticles.shuffle()
    }
        

    func configureBarButton() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchPressed))
        let switchCellButton = UIBarButtonItem(image: UIImage(systemName: "platter.2.filled.iphone"), style: .plain, target: self, action: #selector(switchCellButtonPressed))
        
        navigationItem.rightBarButtonItems = [searchButton, switchCellButton]
    }
    
    func configureTableView(vc: UIViewController) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(bigHomeCell.self, forCellReuseIdentifier: bigHomeCell.reuseIdentifier)
        tableView.register(smallHomeCell.self, forCellReuseIdentifier: smallHomeCell.reuseIdentifier)
        tableView.delegate       = vc as! UITableViewDelegate
        tableView.dataSource     = vc as! UITableViewDataSource
    }
    
    
    //Lets user use bar button to switch between cells to alter layout between big and small cell size. Utilises a bool toggle to switch between layouts
    func bigSmallCell(article: Article) -> UITableViewCell {
        switch sizeBool {
        case true: let cell = tableView.dequeueReusableCell(withIdentifier: bigHomeCell.reuseIdentifier) as! bigHomeCell
            cell.set(article: article, vc: self, tableView: tableView)
            return cell
        case false: let cell = tableView.dequeueReusableCell(withIdentifier: smallHomeCell.reuseIdentifier) as! smallHomeCell
            cell.set(article: article, vc: self, tableView: tableView)
            return cell
        }
    }
    
    
    //Lets user use bar button to switch between cells to alter layout between big and small cell size. Utilises a bool toggle to switch between layouts
    func cellHeight() -> CGFloat {
        switch sizeBool {
        case true: return view.frame.size.height / 2.4
        case false: return view.frame.size.height / 6
        }
    }
    
    
    //Adds empty state view to tableview if no articles present. Can choose between 3 views. Saved, Searched & visited.
    func addEmptyState(array: [Article], state: emptyState) {
        if array.isEmpty == true {
            emptyStateView.set(state: state)
            view.addSubviews(emptyStateView)
            
            NSLayoutConstraint.activate([
                emptyStateView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
                emptyStateView.topAnchor.constraint(equalTo: tableView.topAnchor),
                emptyStateView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
                emptyStateView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
            ])
        } else {
            emptyStateView.removeFromSuperview()
        }
    }
    
    
    //MARK: - @objc Funcs
    
    ///Pressing of nav bar search button opens popover searchVC.
    @objc func searchPressed() {
        let vc = SearchVC()
        vc.modalPresentationStyle = .popover
        vc.modalTransitionStyle = .flipHorizontal
        self.present(vc, animated: true)
    }
    
    
    ///Pressing of nav bar switchCell button reloads tableview with different layout.
    @objc func switchCellButtonPressed() {
        sizeBool.toggle()
        tableView.reloadData()
        tableView.reloadInputViews()
    }
    
}

