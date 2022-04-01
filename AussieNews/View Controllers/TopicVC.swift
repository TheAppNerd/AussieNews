//
//  TopicVC.swift
//  AussieNews
//
//  Created by Alexander Thompson on 29/3/2022.
//

import UIKit

class TopicVC: CustomViewController {
    
   
    var topic: String = ""
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layoutUI()
        
    }
    
    private func configure() {
        tableView.register(smallHomeCell.self, forCellReuseIdentifier: smallHomeCell.reuseIdentifier)
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
        return NewsManager.Shared.newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: smallHomeCell.reuseIdentifier) as! smallHomeCell
        cell.set(article: NewsManager.Shared.newsArticles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 6
    }
    
    
}
