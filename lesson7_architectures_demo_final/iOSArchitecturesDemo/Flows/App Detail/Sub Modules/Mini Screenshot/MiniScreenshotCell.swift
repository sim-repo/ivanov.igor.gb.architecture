//
//  Screenshot_CollectionViewCell.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 24.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class MiniScreenshotCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let throbber = UIActivityIndicatorView(style: .gray)
    private var screenshotURL: URL?
    private let imageDownloader = ImageDownloader()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(screenshotURL: URL){
        self.screenshotURL = screenshotURL
        downloadImage()
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.backgroundColor = .white
        self.addImageView()
        self.addImageViewThrobber()
        self.setupConstraints()
    }
    
    private func addImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.layer.masksToBounds = true
        self.addSubview(self.imageView)
    }
    
    private func addImageViewThrobber() {
        self.throbber.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.addSubview(self.throbber)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            self.throbber.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.throbber.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
    
    
    private func downloadImage() {
        guard let url = self.screenshotURL else { return }
        throbber.startAnimating()
        self.imageDownloader.getImage(fromUrl: url) { (image, error) in
            self.throbber.stopAnimating()
            guard let image = image else { return }
            self.imageView.image = image
        }
    }
}
