//
//  CustomImageView.swift
//  AussieNews
//
//  Created by Alexander Thompson on 22/3/2022.
//

import UIKit

class CustomImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
    }
    
    func downloadImage(from urlString: String) {
        NewsManager.Shared.downloadImage(from: urlString, completed: { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
            
            
        })
    }

}
