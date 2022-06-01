//
//  CustomImageView.swift
//  AussieNews
//
//  Created by Alexander Thompson on 18/3/2022.
//

import UIKit


class CustomLabel: UILabel {

    // MARK: - Class Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(textColor: UIColor, alignment: NSTextAlignment, font: UIFont) {
        self.init(frame: .zero)
        self.textColor     = textColor
        self.textAlignment = alignment
        self.font          = font
    }

    // MARK: - Methods

    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .left
        self.numberOfLines = 0
    }

}
