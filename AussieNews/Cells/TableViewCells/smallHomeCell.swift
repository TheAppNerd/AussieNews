//
//  smallHomeCell.swift
//  AussieNews
//
//  Created by Alexander Thompson on 29/3/2022.
//

import UIKit

class smallHomeCell: DefaultCell {

    // MARK: - Properties

    static let reuseIdentifier = "smallCell"

    // MARK: - Class Funcs

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureButtons()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutUI() {
        let padding: CGFloat = 10

        NSLayoutConstraint.activate([
            articleDateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding / 2),
            articleDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            articleDateLabel.trailingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: -padding),
            articleDateLabel.bottomAnchor.constraint(equalTo: headlineLabel.topAnchor, constant: -padding / 2),

            headlineLabel.topAnchor.constraint(equalTo: articleDateLabel.bottomAnchor, constant: padding / 2),
            headlineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            headlineLabel.trailingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: -padding * 2),
            headlineLabel.bottomAnchor.constraint(equalTo: articleAuthorLabel.topAnchor, constant: -padding),

            articleAuthorLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding),
            articleAuthorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            articleAuthorLabel.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -padding),
            articleAuthorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),

            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            newsImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            newsImage.widthAnchor.constraint(equalTo: newsImage.heightAnchor),

            saveButton.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: padding / 2),
            saveButton.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: padding),
            saveButton.widthAnchor.constraint(equalTo: saveButton.heightAnchor),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),

            shareButton.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: padding / 2),
            shareButton.trailingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: -padding),
            shareButton.widthAnchor.constraint(equalTo: shareButton.heightAnchor),
            shareButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }

}
