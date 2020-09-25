//
//  AppDetailViewController+MiniScreenShots.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 24.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit


extension AppDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {

    
    internal func addScreenshotViewController(topAnchor:  NSLayoutYAxisAnchor) {
      
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: AppDetailConstants.miniScreenshotWidth, height: AppDetailConstants.miniScreenshotHeight)
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .horizontal
        screenshotCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        screenshotCollectionView?.register(MiniScreenshotCell.self, forCellWithReuseIdentifier: "ScreenshotCell")
        screenshotCollectionView?.backgroundColor = .white

        stackView.addArrangedSubview(screenshotCollectionView!)
        
        screenshotCollectionView!.delegate = self
        screenshotCollectionView!.dataSource = self
        
        screenshotCollectionView!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            screenshotCollectionView!.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            screenshotCollectionView!.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            screenshotCollectionView!.heightAnchor.constraint(equalToConstant: AppDetailConstants.miniScreenshotHeight)
        ])
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app.screenshotUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenshotCell", for: indexPath) as! MiniScreenshotCell
        cell.setup(screenshotURL: getScreenshotURL(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.viewDidSelectScreenshot(indexPath: indexPath)
    }
}
