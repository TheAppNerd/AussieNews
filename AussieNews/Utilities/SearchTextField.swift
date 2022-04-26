//
//  SearchTextField.swift
//  AussieNews
//
//  Created by Alexander Thompson on 11/4/2022.
//

import UIKit

class SearchTextField: UITextField {

    //MARK: - Class Funcs
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor          = .label
        layer.cornerRadius = 10
        autocorrectionType = .yes
        returnKeyType      = .search
        clearButtonMode    = .whileEditing
        backgroundColor    = .systemGray3
        placeholder        = "Search Here..."
    }

}
