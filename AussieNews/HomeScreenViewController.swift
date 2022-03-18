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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureVC()
        configureTableView()
        
    }

    func configureVC() {
        view.backgroundColor = .white
        
        
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: HomeScreenTableViewCell.reuseIdentifier)
    }
    
    
    func configureCollectionView() {
        
        
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


