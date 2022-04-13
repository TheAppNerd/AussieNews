//
//  TopicVC.swift
//  AussieNews
//
//  Created by Alexander Thompson on 29/3/2022.
//

import UIKit
import SafariServices

class TopicVC: CustomViewController, SafariProtocol {
    
   
    var topic: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NewsManager.Shared.topic = topic
        getArticles(params: .topic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layoutUI()
        configureBarButton()
        
    }
    
    private func configure() {
        tableView.register(smallHomeCell.self, forCellReuseIdentifier: smallHomeCell.reuseIdentifier)
        tableView.register(bigHomeCell.self, forCellReuseIdentifier: bigHomeCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func layoutUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
    }

}

extension TopicVC: UITableViewDataSource, UITableViewDelegate {
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
