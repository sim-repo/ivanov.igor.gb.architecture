//
//  VersionVoew.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 24.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//


import UIKit

class VersionView: UIView {

    
    private(set) lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 1
        titleLabel.text = "Что нового"
        return titleLabel
    }()
    
    private(set) lazy var versionLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .lightGray
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 1
        return titleLabel
    }()
    
    private(set) lazy var releaseDateLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .lightGray
        titleLabel.textAlignment = .right
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 1
        return titleLabel
    }()
    
    private(set) lazy var releaseNotes: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.versionLabel)
        self.addSubview(self.releaseDateLabel)
        self.addSubview(self.releaseNotes)
        
        NSLayoutConstraint.activate([
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
            
            self.versionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.versionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            self.versionLabel.rightAnchor.constraint(equalTo: releaseDateLabel.leftAnchor, constant: 16.0),

            
            self.releaseDateLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.releaseDateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
            self.releaseDateLabel.widthAnchor.constraint(equalToConstant: 120.0),
            
            self.releaseNotes.topAnchor.constraint(equalTo: self.versionLabel.bottomAnchor, constant: 8),
            self.releaseNotes.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            self.releaseNotes.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0)
        ])
    }
}
