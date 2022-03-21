//
//  SearchVC.swift
//  AussieNews
//
//  Created by Alexander Thompson on 21/3/2022.
//

import UIKit

class SearchVC: UIViewController {

    let textField = UITextField()
    let searchButton = CustomButton()
    let tableView = UITableView()
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
        layoutUI()
        
    
    }

    private func configure() {
        view.backgroundColor = .systemBackground
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        
        textField.backgroundColor = .tertiarySystemBackground
        textField.placeholder = "Search Here..."
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    }
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: HomeScreenTableViewCell.reuseIdentifier)
    }
    
    
    private func layoutUI() {
        view.addSubviews(textField, searchButton, tableView)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            textField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -padding),
            textField.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -padding),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            searchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            searchButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: padding),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            searchButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -padding),
            searchButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: padding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)

        ])
        
    }
    
  

}

//MARK: - UItextFieldDelegate

extension SearchVC: UITextFieldDelegate {
    
    
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeScreenTableViewCell.reuseIdentifier) as! HomeScreenTableViewCell
        return cell
    }
    
    
    
    
}
