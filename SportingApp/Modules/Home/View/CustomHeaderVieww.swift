//
//  CustomHeaderView.swift
//  SportingApp
//
//  Created by habiba on 5/28/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit

class CustomHeaderVieww: UICollectionReusableView {
        let titleLabel: UILabel

         override init(frame: CGRect) {
             titleLabel = UILabel(frame: .zero)
             super.init(frame: frame)
             
             addSubview(titleLabel)
             // Customize titleLabel (e.g., font, color, constraints)
             titleLabel.translatesAutoresizingMaskIntoConstraints = false
             NSLayoutConstraint.activate([
                 titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                 titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
             ])
         }

         required init?(coder: NSCoder) {
             fatalError("init(coder:) has not been implemented")
         }
}
