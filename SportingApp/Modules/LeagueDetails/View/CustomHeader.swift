//
//  CustomHeader.swift
//  SportingApp
//
//  Created by maha on 5/28/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation
import UIKit

class CustomHeader: UITableViewHeaderFooterView {
    let titleLabel: UILabel

    override init(reuseIdentifier: String?) {
        titleLabel = UILabel(frame: .zero)
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.darkGray
        
        // Set title label properties
        titleLabel.textColor = UIColor.white
        //titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 20)
        titleLabel.textAlignment = .left
        addSubview(titleLabel)
       
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), // Align the title to the left with a margin of 16 points
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor) // Center the title vertically
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
