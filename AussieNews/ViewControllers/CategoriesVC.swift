//
//  CategoriesVC.swift
//  AussieNews
//
//  Created by Alexander Thompson on 21/3/2022.
//

import UIKit
import SafariServices

class CategoriesVC: CustomVC, SafariProtocol {

    // MARK: - Properties

    var categoriesCollectionView: UICollectionView!

    // MARK: - Class Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureCollectionView()
        layoutUI()
    }

    // MARK: - Methods

    private func configure() {
        title = "Categories"
        view.backgroundColor = .systemBackground
    }

    private func configureCollectionView() {
        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: Layout.collectionViewLayout(in: view, items: 3))
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        categoriesCollectionView.isScrollEnabled = false
        categoriesCollectionView.delegate        = self
        categoriesCollectionView.dataSource      = self
        view.addSubviews(categoriesCollectionView)
    }

    private func layoutUI() {
        NSLayoutConstraint.activate([
            categoriesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }

}

// MARK: - CollectionView - UICollectionViewDelegate, UICollectionViewDataSource

extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Topics.topicsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
        let topic = Topics.topicsArray[indexPath.item]
        cell.collectionImageView.image = UIImage(named: topic)
        cell.collectionLabel.text = topic
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topic = Topics.topicsArray[indexPath.item]
        let vc    = TopicVC()
        vc.topic  = topic
        show(vc, sender: self)
    }

}
