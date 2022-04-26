//
//  TopicVC.swift
//  AussieNews
//
//  Created by Alexander Thompson on 29/3/2022.
//

import UIKit
import SafariServices


class TopicVC: CustomViewController, SafariProtocol {
    
    //MARK: - Properties
    
    var topic: String = ""
    
    
    //Class Funcs
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NewsManager.Shared.topic = topic
        getArticles(params: .topic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = topic
        configureTableView(vc: self)
        layoutUI()
        configureBarButton()
    }
  
    
    //MARK: - Functions
    
    private func layoutUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
}

//MARK: - TableView - UITableViewDelegate, UITableViewDataSource

extension TopicVC: UITableViewDelegate, UITableViewDataSource {
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
