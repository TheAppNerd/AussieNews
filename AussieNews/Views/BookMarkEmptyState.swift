//
//  BookMarkEmptyState.swift
//  AussieNews
//
//  Created by Alexander Thompson on 21/3/2022.
//

import UIKit

class BookMarkEmptyState: UIView {
    
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

    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
       
        emptyImage.translatesAutoresizingMaskIntoConstraints = false
        emptyImage.tintColor = .secondaryLabel
        emptyImage.image = UIImage(systemName: "bookmark")
        
        emptyTitleLabel.text = "No Saved Content"
        emptyTitleLabel.textAlignment = .center
        emptyTitleLabel.textColor = .secondaryLabel
        emptyTitleLabel.font = UIFont.systemFont(ofSize: 20)
        
        emptySecondaryLabel.text = """
        Looks like you havent saved anything yet.
        Tap on bookmark to start saving content.
        """
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
