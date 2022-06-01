//
//  PageControl.swift
//  AussieNews
//
//  Created by Alexander Thompson on 1/6/2022.
//

import UIKit

class PageControl: UIPageControl {

    // MARK: - Class Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius            = 15
        numberOfPages                 = 6
        pageIndicatorTintColor        = .secondaryLabel
        currentPageIndicatorTintColor = .label
        backgroundColor               = Color.aussieGreen
    }

}
