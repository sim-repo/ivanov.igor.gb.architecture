//
//  AppDetailPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 25.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit


protocol  AppDetailInput {
    var app: ITunesApp {get set}
}

// incoming from vc
protocol  AppDetailOutput {
    func viewDidSelectScreenshot(indexPath: IndexPath)
}


class AppDetailPresenter {
    
    weak var viewInput: (UIViewController & AppDetailInput)?
    private (set) var app: ITunesApp
    
    
    init(app: ITunesApp ) {
        self.app = app
    }
    
    func setup(with viewInput: UIViewController & AppDetailInput) {
        self.viewInput = viewInput
        self.viewInput!.app = app
    }
}


extension AppDetailPresenter: AppDetailOutput {
    
    func viewDidSelectScreenshot(indexPath: IndexPath) {
        
        let urls: [URL] = app.screenshotUrls.map{ URL(string: $0)! }
        let vc = ScreenshotPageVC(screenshotURLs: urls, firstSelectedScreenshotNo: indexPath.row)
        vc.modalPresentationStyle = .custom
        viewInput?.present(vc, animated: true)
    }
}

