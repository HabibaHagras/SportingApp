//
//  CustomHeaderView.swift
//  SportingApp
//
//  Created by habiba on 5/28/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit
import UIKit

class CustomHeaderVieww: UICollectionReusableView {
    let titleLabel: UILabel

    override init(frame: CGRect) {
        titleLabel = UILabel(frame: .zero)
        super.init(frame: frame)
        
        self.backgroundColor = .black

        titleLabel.text = "Welcome Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
