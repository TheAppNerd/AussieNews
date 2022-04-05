//
//  SettingsTintCell.swift
//  AussieNews
//
//  Created by Alexander Thompson on 5/4/2022.
//

import UIKit

class SettingsTintCell: UITableViewCell {
    
    static let reuseIdentifier = "SettingsTintCell"
    
    let tintStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    private func configure() {
        let colorArray = [UIColor.systemRed, UIColor.systemBlue, UIColor.systemPink, UIColor.systemGreen, UIColor.systemOrange, UIColor.systemPurple, UIColor.systemTeal]
        
        for num in 0...6 {
            let button = CustomButton()
            button.backgroundColor = colorArray[num]
            button.addTarget(self, action: #selector(tintButtonPressed), for: .touchUpInside)
            button.layer.borderColor = UIColor.label.cgColor
            tintStack.addArrangedSubview(button)
        }
        
        tintStack.alignment = .fill
        tintStack.distribution = .fillEqually
        tintStack.spacing = 5
        tintStack.axis = .horizontal
        tintStack.translatesAutoresizingMaskIntoConstraints = false
        tintStack.backgroundColor = .secondarySystemBackground
        tintStack.layer.cornerRadius = 10
    }
    
    @objc func tintButtonPressed(sender: CustomButton) {
        for button in tintStack.arrangedSubviews {
            button.layer.borderWidth = 0
        }
        sender.layer.borderWidth = 2
        UIApplication.shared.windows.forEach { window in
            window.tintColor = sender.backgroundColor
            
        }
    }
    
    
    private func layoutUI() {
        contentView.addSubview(tintStack)
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            tintStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            tintStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            tintStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            tintStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
}
