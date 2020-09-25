//
//  DescView.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 24.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class DescView: UIView {

    private(set) lazy var descLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.descLabel)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(self.descLabel)

        NSLayoutConstraint.activate([
            self.descLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            self.descLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0)
        ])
    }
    

}
