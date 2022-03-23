//
//  TrendingView.swift
//  AussieNews
//
//  Created by Alexander Thompson on 23/3/2022.
//

import UIKit

class TrendingView: UIView {
    //use matching names across all cells and views
    let newsImage = CustomImageView(frame: .zero)
    var headline = CustomLabel()

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
        self.layer.cornerRadius = 10
        self.backgroundColor = .tertiarySystemBackground
        
        headline.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        headline.numberOfLines = 0
        headline.textAlignment = .center
        headline.textColor = .black
        headline.layer.cornerRadius = 10
    
        
        newsImage.contentMode = .scaleAspectFit
        newsImage.layer.cornerRadius = 10
        
        
    }
    
    private func layoutUI() {
        self.addSubviews(newsImage)
        newsImage.addSubview(headline)
        NSLayoutConstraint.activate([
            
            newsImage.topAnchor.constraint(equalTo: self.topAnchor),
            newsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            newsImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            headline.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor),
            headline.trailingAnchor.constraint(equalTo: newsImage.trailingAnchor),
            headline.bottomAnchor.constraint(equalTo: newsImage.bottomAnchor),
            headline.heightAnchor.constraint(equalTo: newsImage.heightAnchor, multiplier: 0.4)
        ])
        
        
    }
    
    func set(imageString: String, labelText: String) {
        self.newsImage.downloadImage(from: imageString)
        self.headline.text = labelText
        self.layoutIfNeeded()
        
    }
}
