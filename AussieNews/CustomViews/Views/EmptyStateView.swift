//
//  BookMarkEmptyState.swift
//  AussieNews
//
//  Created by Alexander Thompson on 21/3/2022.
//

import UIKit

class EmptyStateView: UIView {

    // MARK: - Properties

    let emptyImage          = CustomImageView(frame: .zero)
    let emptyTitleLabel     = CustomLabel(textColor: .secondaryLabel, alignment: .center, font: UIFont.systemFont(ofSize: 20))
    let emptySecondaryLabel = CustomLabel(textColor: .secondaryLabel, alignment: .center, font: UIFont.systemFont(ofSize: 20))

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

    /// Called from primary viewControllers to select which empty state to show based on where in the app this is called.
    func set(state: EmptyState) {
        switch state {
        case .search:
            emptyImage.image         = EmptyStateConstant.searchImage
            emptyTitleLabel.text     = EmptyStateConstant.searchTitle
            emptySecondaryLabel.text = EmptyStateConstant.searchSecondary
        case .saved:
            emptyImage.image         = EmptyStateConstant.savedImage
            emptyTitleLabel.text     = EmptyStateConstant.savedTitle
            emptySecondaryLabel.text = EmptyStateConstant.savedSecondary
        case .visited:
            emptyImage.image         = EmptyStateConstant.visitedImage
            emptyTitleLabel.text     = EmptyStateConstant.visitedTitle
            emptySecondaryLabel.text = EmptyStateConstant.visitedSecondary
        }
    }

    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        emptyImage.tintColor = .secondaryLabel
    }

    private func layoutUI() {
        self.addSubviews(emptyImage, emptyTitleLabel, emptySecondaryLabel)
        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            emptyImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            emptyImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            emptyImage.heightAnchor.constraint(equalTo: emptyImage.widthAnchor),

            emptyTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            emptyTitleLabel.topAnchor.constraint(equalTo: emptyImage.bottomAnchor, constant: padding),
            emptyTitleLabel.bottomAnchor.constraint(equalTo: emptySecondaryLabel.topAnchor, constant: -padding),

            emptySecondaryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptySecondaryLabel.topAnchor.constraint(equalTo: emptyTitleLabel.bottomAnchor, constant: padding),
            emptySecondaryLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
}
