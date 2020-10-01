//
//  AppDetailHeaderViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 9/21/20.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class AppDetailHeaderVC: UIViewController {

    private let app: ITunesApp
    private let imageDownLoader = ImageDownloader()
    
    private var appDetailHeaderView: AppDetailHeaderView {
        return view as! AppDetailHeaderView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = AppDetailHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()
    }
    
    private func fillData() {
        downloadImage()
        appDetailHeaderView.titleLabel.text = app.appName
        appDetailHeaderView.subTitleLabel.text = app.company
        appDetailHeaderView.ratingLabel.text = app.averageRating.flatMap { "\($0)" }
    }
    
    private func downloadImage() {
        guard let url = app.iconUrl else { return }
        
        imageDownLoader.getImage(fromUrl: url) { [weak self] (image, _) in
            DispatchQueue.main.async {
                self?.appDetailHeaderView.imageView.image = image
            }
        }
    }
}
