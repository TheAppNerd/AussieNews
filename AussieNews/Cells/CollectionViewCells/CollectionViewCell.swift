//
//  CollectionViewCell.swift
//  AussieNews
//
//  Created by Alexander Thompson on 18/3/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    static let reuseIdentifier = "CollectionViewCell"
    lazy var imageView         = CustomImageView(frame: .zero)
    let collectionLabel        = CustomLabel()

    // MARK: - Class Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func set(topic: String) {
        imageView.image = UIImage(named: topic)
        collectionLabel.text      = topic
    }

    private func configure() {
        imageView.addSubview(collectionLabel)
        imageView.layer.cornerRadius  = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode         = .scaleAspectFill

        collectionLabel.textAlignment           = .center
        collectionLabel.layer.cornerRadius      = 10
        collectionLabel.layer.masksToBounds     = true
        collectionLabel.textColor               = .white
        collectionLabel.font                    = UIFont.boldSystemFont(ofSize: 12)
        collectionLabel.backgroundColor         = UIColor.black.withAlphaComponent(0.5)

        contentView.layer.cornerRadius          = 10
        contentView.layer.borderWidth           = 1
        contentView.layer.borderColor           = Color.aussieGreen.cgColor
    }

    private func layoutUI() {
        contentView.addSubviews(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            collectionLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            collectionLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            collectionLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

}
