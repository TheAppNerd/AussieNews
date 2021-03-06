//
//  SeconfViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 17/3/2022.
//

import UIKit
import SafariServices

class SavedVC: CustomVC {
    
    // MARK: - Properties
    
    let emptyState       = EmptyStateView()
    let bookmarkButton   = UIButton()
    let recentButton     = UIButton()
    let lineOne          = UIView()
    let lineTwo          = UIView()
    let userDefaultFuncs = UserDefaultFuncs()
    
    // MARK: - Class Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel()
        bookmarkButton.sendActions(for: .touchUpInside)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureBarButtons()
        configureButtons()
        configureTableView(vc: self)
        layoutUI()
    }
    
    // MARK: - Methods
    
    private func configure() {
        title                = "Saved"
        view.backgroundColor = .systemBackground
    }

    private func configureBarButtons() {
        let clearButton                   = UIBarButtonItem(title: "Clear All", style: .done, target: self, action: #selector(clearPressed))
        clearButton.tintColor             = Color.aussieGreen
        navigationItem.rightBarButtonItem = clearButton
    }
    
    private func configureButtons() {
        bookmarkButton.setButtonPurpose(.bookmark)
        
        bookmarkButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        
        recentButton.setButtonPurpose(.recent)
        recentButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        
        lineOne.backgroundColor = .secondaryLabel
        lineOne.translatesAutoresizingMaskIntoConstraints = false
        
        lineTwo.backgroundColor = .secondaryLabel
        lineTwo.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func updateLabel() {
        userDefaultFuncs.retrieveArticles()
        bookmarkButton.setTitle("Saved \(userDefaultFuncs.savedArticleArray.count)", for: .normal)
    }
    
    private func layoutUI(){
        view.addSubviews(bookmarkButton, recentButton, lineOne, lineTwo, tableView)
        
        NSLayoutConstraint.activate([
            bookmarkButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookmarkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookmarkButton.trailingAnchor.constraint(equalTo: recentButton.leadingAnchor),
            bookmarkButton.bottomAnchor.constraint(equalTo: lineOne.topAnchor),
            bookmarkButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 50),
            
            recentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recentButton.leadingAnchor.constraint(equalTo: bookmarkButton.trailingAnchor),
            recentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recentButton.bottomAnchor.constraint(equalTo: lineTwo.topAnchor),
            recentButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            recentButton.heightAnchor.constraint(equalToConstant: 50),
            
            lineOne.topAnchor.constraint(equalTo: bookmarkButton.bottomAnchor),
            lineOne.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineOne.trailingAnchor.constraint(equalTo: lineTwo.leadingAnchor),
            lineOne.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            lineOne.heightAnchor.constraint(equalToConstant: 2),
            
            lineTwo.topAnchor.constraint(equalTo: recentButton.bottomAnchor),
            lineTwo.leadingAnchor.constraint(equalTo: lineOne.trailingAnchor),
            lineTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineTwo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            lineTwo.heightAnchor.constraint(equalToConstant: 2),
            
            tableView.topAnchor.constraint(equalTo: lineOne.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - @Objc Methods
    
    /// Generates an alert to clear all articles from either saved or visited articles in UserDefaults.
    @objc func clearPressed() {
        let alert = UIAlertController(title: "Clear Articles", message: "Are you sure you wish to clear this list?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            if self.bookmarkButton.isSelected == true {
                self.userDefaultFuncs.clearArticles(.saved)
                self.addEmptyState(array: self.userDefaultFuncs.savedArticleArray, state: .saved)
            } else {
                self.userDefaultFuncs.clearArticles(.visited)
                self.addEmptyState(array: self.userDefaultFuncs.visitedArticleArray, state: .visited)
            }
            self.updateLabel()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        present(alert, animated: true)
    }
    
    
    // Alternates between displaying saved articles & visited Articles
    @objc func buttonPressed(sender: UIButton) {
        let buttonArray = [bookmarkButton, recentButton]
        for button in buttonArray {
            button.isSelected = false
            button.setTitleColor(.secondaryLabel, for: .normal)
        }
        sender.isSelected = true
        lineOne.backgroundColor = .secondaryLabel
        lineTwo.backgroundColor = .secondaryLabel
        
        if sender == bookmarkButton {
            lineOne.backgroundColor = Color.aussieGreen
            bookmarkButton.setTitleColor(Color.aussieGreen, for: .normal)
            addEmptyState(array: userDefaultFuncs.savedArticleArray, state: .saved)
        } else if sender ==  recentButton {
            recentButton.setTitleColor(Color.aussieGreen, for: .normal)
            lineTwo.backgroundColor = Color.aussieGreen
            addEmptyState(array: userDefaultFuncs.visitedArticleArray, state: .visited)
        }
        tableView.reloadData()
    }

    @objc func saveButtonPressed() {
        self.updateLabel()
        tableView.reloadData()
    }
}


// MARK: - TableView - TableViewDelegate, TableViewDataSource

extension SavedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bookmarkButton.isSelected {
            return userDefaultFuncs.savedArticleArray.count
        } else {
            return userDefaultFuncs.visitedArticleArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: smallHomeCell.reuseIdentifier) as! smallHomeCell
        cell.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        if bookmarkButton.isSelected {
            cell.set(article: userDefaultFuncs.savedArticleArray[indexPath.row], vc: self)
        } else {
            cell.set(article: userDefaultFuncs.visitedArticleArray[indexPath.row], vc: self)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article: Article?
        if bookmarkButton.isSelected {
            article = userDefaultFuncs.savedArticleArray[indexPath.row]
        } else {
            article = userDefaultFuncs.visitedArticleArray[indexPath.row]
        }
        
        if let article = article {
            showArticle(self, article: article)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.size.height / 6
    }
    
}

