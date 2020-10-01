//
//  AppDetailVersionViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 24.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class VersionAppDetailVC: UIViewController {
    
    private let app: ITunesApp //TODO: refactor
    
    private var verView: VersionView {
        return view as! VersionView
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
        self.view = VersionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()
    }
    
    private func fillData() {
        if let version = app.version {
            verView.versionLabel.text =  "Версия \(version)"
        }
        
        if let date = app.currentVersionReleaseDate {
            let formatted = DateHelper.getSimpleStrDate(date: date)
            verView.releaseDateLabel.text = formatted
        }
        verView.releaseNotes.text = app.releaseNotes
    }
    
    func preferredHeight() -> CGFloat {
        var height: CGFloat = 0
        height = verView.titleLabel.getSize(constrainedWidth: screenSize.width).height
        height += verView.versionLabel.getSize(constrainedWidth: screenSize.width).height
        height += verView.releaseNotes.getSize(constrainedWidth: screenSize.width).height + 16
        return height
    }
}
