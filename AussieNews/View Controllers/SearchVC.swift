//
//  SearchVC.swift
//  AussieNews
//
//  Created by Alexander Thompson on 21/3/2022.
//

import UIKit

//goals: enter text into search field to search params
//save previous searches?

class SearchVC: CustomViewController {

    let textField = SearchTextField()
    let searchButton = CustomButton()
    let topView = UIView()
    let line = UIView()
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
        layoutUI()
        addEmptyState(array: newsArticles, state: .search)
    }

    private func configure() {
        view.backgroundColor = .systemBackground
        textField.delegate = self
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        searchButton.backgroundColor = .orange
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .secondarySystemBackground
        
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .tertiarySystemBackground
    }
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(smallHomeCell.self, forCellReuseIdentifier: smallHomeCell.reuseIdentifier)
    }
    
    
    
        
    
    
    private func layoutUI() {
        view.addSubviews(textField, searchButton, tableView, topView)
        topView.addSubview(line)
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 40),
            
            line.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            line.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            line.heightAnchor.constraint(equalToConstant: 2),
            line.widthAnchor.constraint(equalToConstant: 30),
            
            textField.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: padding),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            textField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -padding / 2),
            textField.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -padding),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            searchButton.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: padding),
            searchButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: padding / 2),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            searchButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -padding),
            searchButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: padding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)

        ])
    }
    
    @objc func searchButtonPressed() {
        textFieldDidEndEditing(textField)
    }

}

//MARK: - UItextFieldDelegate

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField.text != "" else { return }
        newsArticles.removeAll()
        NewsManager.Shared.searchString = textField.text!
        getArticles(params: .search)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = newsArticles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: smallHomeCell.reuseIdentifier) as! smallHomeCell
        
        cell.set(article: article, vc: self, tableView: tableView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return view.frame.size.height / 6
       
        }
    }
    
    

