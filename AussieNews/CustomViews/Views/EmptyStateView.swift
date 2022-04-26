//
//  BookMarkEmptyState.swift
//  AussieNews
//
//  Created by Alexander Thompson on 21/3/2022.
//

import UIKit

///Called from primary viewControllers to add a view over tableViews if no data is present.
class EmptyStateView: UIView {
    
//MARK: - Properties
    
    let emptyImage          = CustomImageView(frame: .zero)
    let emptyTitleLabel     = CustomLabel()
    let emptySecondaryLabel = CustomLabel()

    
    //MARK: - Class Funcs
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions

    ///Called from primary viewControllers to select which empty state to show based on where in the app this is called.
    func set(state: emptyState) {
        switch state {
        case .search:
            emptyImage.image         = emptyStateConstant.searchImage
            emptyTitleLabel.text     = emptyStateConstant.searchTitle
            emptySecondaryLabel.text = emptyStateConstant.searchSecondary
        case .saved:
            emptyImage.image         = emptyStateConstant.savedImage
            emptyTitleLabel.text     = emptyStateConstant.savedTitle
            emptySecondaryLabel.text = emptyStateConstant.savedSecondary
        case .visited:
            emptyImage.image         = emptyStateConstant.visitedImage
            emptyTitleLabel.text     = emptyStateConstant.visitedTitle
            emptySecondaryLabel.text = emptyStateConstant.visitedSecondary
        }
    }
    
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        emptyImage.tintColor              = .secondaryLabel
        
        emptyTitleLabel.textAlignment     = .center
        emptyTitleLabel.textColor         = .secondaryLabel
        emptyTitleLabel.font              = UIFont.systemFont(ofSize: 20)
        
        emptySecondaryLabel.textAlignment = .center
        emptySecondaryLabel.textColor     = .secondaryLabel
        emptySecondaryLabel.font          = UIFont.systemFont(ofSize: 20)
        emptySecondaryLabel.numberOfLines = 0
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
