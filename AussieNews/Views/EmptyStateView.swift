//
//  BookMarkEmptyState.swift
//  AussieNews
//
//  Created by Alexander Thompson on 21/3/2022.
//

import UIKit

class EmptyStateView: UIView {
    
    
    
    let emptyImage = UIImageView()
    let emptyTitleLabel = CustomLabel()
    let emptySecondaryLabel = CustomLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(state: emptyState) {
        switch state {
        case .search:
            emptyImage.image = UIImage(systemName: "magnifyingglass")
            emptyTitleLabel.text = "No Search Results"
            emptySecondaryLabel.text = """
            Looks like you havent searched anything yet.
            Use the text field above to swarch for anything you want.
            """
        case .saved:
            emptyImage.image = UIImage(systemName: "bookmark")
            emptyTitleLabel.text = "No Saved Content"
            emptySecondaryLabel.text = """
            Looks like you havent saved anything yet.
            Tap on bookmark to start saving content.
            """
        case .visited:
            emptyImage.image = UIImage(systemName: "list.bullet.rectangle.portrait")
            emptyTitleLabel.text = "No Visited Pages"
            emptySecondaryLabel.text = """
            Looks like you havent ready any articles yet.
            Read some news articles to fill this list.
            """
        }
        
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        emptyImage.translatesAutoresizingMaskIntoConstraints = false
        emptyImage.tintColor = .secondaryLabel
        
        emptyTitleLabel.textAlignment = .center
        emptyTitleLabel.textColor = .secondaryLabel
        emptyTitleLabel.font = UIFont.systemFont(ofSize: 20)
        
        emptySecondaryLabel.textAlignment = .center
        emptySecondaryLabel.textColor = .secondaryLabel
        emptySecondaryLabel.font = UIFont.systemFont(ofSize: 20)
    }
    
    
    private func layoutUI() {
        self.addSubviews(emptyImage, emptyTitleLabel, emptySecondaryLabel)
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
        
            emptyImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            emptyImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            emptyImage.heightAnchor.constraint(equalTo: emptyImage.widthAnchor),
            
            emptyTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            emptyTitleLabel.topAnchor.constraint(equalTo: emptyImage.bottomAnchor, constant: padding),
            emptyTitleLabel.bottomAnchor.constraint(equalTo: emptySecondaryLabel.topAnchor, constant: -padding),
            
            emptySecondaryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptySecondaryLabel.topAnchor.constraint(equalTo: emptyTitleLabel.bottomAnchor, constant: padding),
            emptySecondaryLabel.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    
}
