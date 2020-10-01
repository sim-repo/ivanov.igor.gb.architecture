//
//  ScreenshotVC.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 24.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class ScreenshotVC: UIViewController {
    
    public var pageIndex: Int!
    private var screenshotURL: URL!
    
    private let imageView = UIImageView()
    private let throbber = UIActivityIndicatorView(style: .gray)
    private let imageDownloader = ImageDownloader()
    
    
    init(screenshotURL: URL, pageIndex: Int) {
        self.pageIndex = pageIndex
        self.screenshotURL = screenshotURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
      //  self.view.addSubview(throbber)
        setupConstraints()
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
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
    }
}
