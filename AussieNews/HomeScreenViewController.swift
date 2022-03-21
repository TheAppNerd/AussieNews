//
//  ViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 17/3/2022.
//

import UIKit

class HomeScreenViewController: UIViewController {

   // let collectionView = UICollectionView()
    let tableView = UITableView()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureVC()
        configureTableView()
        configureBarButton()
        layoutUI()
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
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: HomeScreenTableViewCell.reuseIdentifier)
    }
    
    
    func configureCollectionView() {
        
        
    }
    
    func layoutUI() {
        view.addSubviews(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        
        ])
        
    }
    
    @objc func searchPressed() {
        print("search pressed")
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeScreenTableViewCell.reuseIdentifier) as! HomeScreenTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    
    
}


