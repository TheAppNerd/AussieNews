//
//  SeconfViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 17/3/2022.
//

import UIKit

class SavedVC: UIViewController {
    
    let emptyState = BookMarkEmptyState()
    let bookmarkButton = CustomButton()
    let recentButton = CustomButton()
    let tableView = UITableView()
    let lineOne = UIView()
    let lineTwo = UIView()
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookmarkButton.sendActions(for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureButtons()
        configureTableView()
        layoutUI()
    }
    
    
    private func configure() {
        title = "Saved"
        view.backgroundColor = .systemBackground
        
        let clearButton = UIBarButtonItem(title: "Clear All", style: .done, target: self, action: #selector(clearPressed))
        clearButton.tintColor = .orange
        navigationItem.rightBarButtonItem = clearButton
    }
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: HomeScreenTableViewCell.reuseIdentifier)
    }
    
    private func configureButtons() {
        bookmarkButton.setTitle("Saved 7", for: .normal)
        bookmarkButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        bookmarkButton.backgroundColor = .systemBackground
        bookmarkButton.setTitleColor(.black, for: .normal)
        
        recentButton.setTitle("Recently Viewed", for: .normal)
        recentButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        recentButton.backgroundColor = .systemBackground
        
        recentButton.setTitleColor(.black, for: .normal)
        
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
    
    @objc func clearPressed() {
        
    }
    

    @objc func buttonPressed(sender: CustomButton) {
        
            lineOne.backgroundColor = .secondaryLabel
            lineTwo.backgroundColor = .secondaryLabel
        bookmarkButton.setTitleColor(.secondaryLabel, for: .normal)
        recentButton.setTitleColor(.secondaryLabel, for: .normal)
            
        if sender == bookmarkButton {
            lineOne.backgroundColor = .orange
            bookmarkButton.setTitleColor(.orange, for: .normal)
        } else if sender ==  recentButton {
            recentButton.setTitleColor(.orange, for: .normal)
            lineTwo.backgroundColor = .orange
        }
    }
}


//MARK: - TableViewDelegate, TableViewDataSource

extension SavedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeScreenTableViewCell.reuseIdentifier) as! HomeScreenTableViewCell
        return cell
    }
    
    
    
}
