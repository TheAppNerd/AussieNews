//
//  TrendingStackView.swift
//  AussieNews
//
//  Created by Alexander Thompson on 22/4/2022.
//

import UIKit

class TrendingStackView: UIStackView {

    // MARK: -  Class Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        alignment    = .fill
        spacing      = 10
        distribution = .fillEqually
        axis         = .horizontal
    }

}
