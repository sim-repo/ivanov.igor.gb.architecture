//
//  AppDetailDescViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 24.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit


class DescAppDetailVC: UIViewController {
    
    private let app: ITunesApp //TODO: refactor
    
    private var descView: DescView {
        return view as! DescView
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
        self.view = DescView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()
    }
    
    private func fillData() {
        descView.descLabel.text = app.appDescription
    }
    
    func preferredHeight() -> CGFloat {
        return descView.descLabel.getSize(constrainedWidth: screenSize.width).height
    }
}
