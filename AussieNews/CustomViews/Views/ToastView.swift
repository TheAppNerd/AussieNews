//
//  ToastView.swift
//  AussieNews
//
//  Created by Alexander Thompson on 31/5/2022.
//

import UIKit

class ToastView: UIView {

    let imageView   = CustomImageView(frame: .zero)
    let mainLabel   = CustomLabel(textColor: .label, alignment: .left, font: UIFont.boldSystemFont(ofSize: 16))
    let secondLabel = CustomLabel(textColor: .secondaryLabel, alignment: .left, font: UIFont.systemFont(ofSize: 16))

    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor              = .secondarySystemBackground
        layer.cornerRadius           = 10
        layer.masksToBounds          = true

        mainLabel.adjustsFontSizeToFitWidth   = true
        secondLabel.adjustsFontSizeToFitWidth = true

        imageView.tintColor                   = Color.aussieGreen
    }

    func set(image: UIImage, mainText: String, secondText: String) {
        imageView.image  = image
        mainLabel.text   = mainText
        secondLabel.text = secondText
    }

    private func layoutUI() {
        addSubviews(imageView, mainLabel, secondLabel)

        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),

            mainLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            mainLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            mainLabel.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.5),
            mainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            secondLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            secondLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            secondLabel.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.5),
            secondLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

}
