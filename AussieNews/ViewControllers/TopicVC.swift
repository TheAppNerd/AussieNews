//
//  TopicVC.swift
//  AussieNews
//
//  Created by Alexander Thompson on 29/3/2022.
//

import UIKit
import SafariServices

class TopicVC: CustomVC {

    // MARK: - Properties

    var topic: String = ""

   // MARK: - Class Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        Configure()
        configureTableView(vc: self)
        configureBarButton()
        newsManager.topic = topic
        getArticles(params: .topic)
    }

    // MARK: - Methods

    private func Configure() {
        title = topic
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }

    func configureTableViewRefresh() {
        tableView.refreshControl = tableViewRefresh
        tableViewRefresh.addTarget(self, action: #selector(refreshStarted), for: .valueChanged)
    }

    // MARK: - @Objc Methods
    
    @objc func refreshStarted() {
        newsArticles.removeAll()
        getArticles(params: .topic)
        generator.impactOccurred()
    }
}

// MARK: - TableView - UITableViewDelegate, UITableViewDataSource

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
