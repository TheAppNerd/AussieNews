//
//  ViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 17/3/2022.
//

import UIKit

class HomeVC: UIViewController {

    var collectionView: UICollectionView!
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureCollectionView()
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
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.width / 4),
            
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
        return cell
    }
    
    
 
    
    
}


