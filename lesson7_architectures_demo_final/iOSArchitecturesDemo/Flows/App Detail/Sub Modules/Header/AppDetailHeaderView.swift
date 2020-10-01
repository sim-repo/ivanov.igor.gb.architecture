//
//  AppDetailHeaderView.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 9/21/20.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class AppDetailHeaderView: UIView {
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private(set) lazy var subTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .lightGray
        titleLabel.font = UIFont.systemFont(ofSize: 14.0)
        return titleLabel
    }()
    
    private(set) lazy var openButton: UIButton = {
        let openButton = UIButton()
        openButton.translatesAutoresizingMaskIntoConstraints = false
        openButton.setTitle("Оpen", for: .normal)
        openButton.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        openButton.layer.cornerRadius = 16.0
        return openButton
    }()
    
    private(set) lazy var ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.textColor = .lightGray
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        return ratingLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subTitleLabel)
        self.addSubview(self.openButton)
        self.addSubview(self.ratingLabel)
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12.0),
            self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            self.imageView.widthAnchor.constraint(equalToConstant: 120.0),
            self.imageView.heightAnchor.constraint(equalToConstant: 120.0),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12.0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 16.0),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
            
            self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12.0),
            self.subTitleLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor),
            self.subTitleLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor),
            
            self.openButton.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 16.0),
            self.openButton.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor),
            self.openButton.widthAnchor.constraint(equalToConstant: 80.0),
            self.openButton.heightAnchor.constraint(equalToConstant: 32.0),
            
            self.ratingLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 24.0),
            self.ratingLabel.leftAnchor.constraint(equalTo: self.imageView.leftAnchor),
            self.ratingLabel.widthAnchor.constraint(equalToConstant: 100.0),
            
            self.ratingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
}
