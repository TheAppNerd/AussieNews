//
//  SettingsSegmentCell.swift
//  AussieNews
//
//  Created by Alexander Thompson on 5/4/2022.
//

import UIKit

class SettingsSegmentCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseIdentifier = "SettingsSegmentCell"
    let darkModeSegment        = UISegmentedControl()
    
    //MARK: - Class Funcs
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func configure() {
        contentView.backgroundColor = .secondarySystemBackground
        darkModeSegment.translatesAutoresizingMaskIntoConstraints = false
        darkModeSegment.backgroundColor          = .tertiarySystemBackground
        darkModeSegment.selectedSegmentTintColor = color.aussieGreen
        for num in 0...2  {
            darkModeSegment.insertSegment(withTitle: darkMode.segmentArray[num], at: num, animated: true)
        }
    }
    
    
    private func layoutUI() {
        contentView.addSubview(darkModeSegment)
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            darkModeSegment.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            darkModeSegment.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            darkModeSegment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            darkModeSegment.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
}
