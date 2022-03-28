//
//  SeconfViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 17/3/2022.
//

import UIKit

class SavedVC: UIViewController {
    
    //MARK: - variables & constants
    
    let emptyState       = BookMarkEmptyState()
    let bookmarkButton   = CustomButton()
    let recentButton     = CustomButton()
    let tableView        = UITableView()
    let lineOne          = UIView()
    let lineTwo          = UIView()
    let userDefaultFuncs = UserDefaultFuncs()
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureButtons()
        bookmarkButton.sendActions(for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        configureTableView()
        layoutUI()
        userDefaultFuncs.retrievePages()
    }
    
    //MARK: - Funcs
    
    
    private func configure() {
        title = "Saved"
        view.backgroundColor              = .systemBackground
        
        let clearButton                   = UIBarButtonItem(title: "Clear All", style: .done, target: self, action: #selector(clearPressed))
        clearButton.tintColor             = .orange
        navigationItem.rightBarButtonItem = clearButton
    }
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: HomeScreenTableViewCell.reuseIdentifier)
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    private func configureButtons() {
        bookmarkButton.setTitle("Saved \(UserDefaultFuncs.savedPagesArray.count)", for: .normal)
        bookmarkButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        bookmarkButton.setTitleColor(.secondaryLabel, for: .normal)
        
        
        recentButton.setTitle("Recently Viewed", for: .normal)
        recentButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        recentButton.setTitleColor(.secondaryLabel, for: .normal)
        
        lineOne.backgroundColor = .secondaryLabel
        lineOne.translatesAutoresizingMaskIntoConstraints = false
        
        lineTwo.backgroundColor = .secondaryLabel
        lineTwo.translatesAutoresizingMaskIntoConstraints = false
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
        
        
//        view.addSubview(emptyState)
//        NSLayoutConstraint.activate([
//            emptyState.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            emptyState.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            emptyState.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            emptyState.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
    }
    
    
    
    //MARK: - @objc Funcs
    
    @objc func clearPressed() {
        
    }
    

    @objc func buttonPressed(sender: CustomButton) {
        let buttonArray = [bookmarkButton, recentButton]
        for button in buttonArray {
            button.isSelected = false
            button.setTitleColor(.secondaryLabel, for: .normal)
        }
        sender.isSelected = true
            lineOne.backgroundColor = .secondaryLabel
            lineTwo.backgroundColor = .secondaryLabel
            
        if sender == bookmarkButton {
            lineOne.backgroundColor = .orange
            bookmarkButton.setTitleColor(.orange, for: .normal)
        } else if sender ==  recentButton {
            recentButton.setTitleColor(.orange, for: .normal)
            lineTwo.backgroundColor = .orange
        }
        tableView.reloadData()
    }
    
    @objc func saveButtonPressed() {
        tableView.reloadData()
        bookmarkButton.setTitle("Saved \(UserDefaultFuncs.savedPagesArray.count)", for: .normal)
    }
}


//MARK: - TableViewDelegate, TableViewDataSource

extension SavedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bookmarkButton.isSelected {
            return UserDefaultFuncs.savedPagesArray.count
        } else {
            return UserDefaultFuncs.visitedPagesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeScreenTableViewCell.reuseIdentifier) as! HomeScreenTableViewCell
        cell.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        if bookmarkButton.isSelected {
            cell.set(article: UserDefaultFuncs.savedPagesArray[indexPath.row])
        } else {
            cell.set(article: UserDefaultFuncs.visitedPagesArray[indexPath.row])
        }
        return cell
    }
}
