//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailVC: UIViewController {
    
    public var app: ITunesApp
    
    lazy var headerViewController = AppDetailHeaderViewController(app: app)
    lazy var versionVC = Version_AppDetailViewController(app: app)
    var screenshotCollectionView: UICollectionView?
    
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var appDetailView: AppDetailView {
        return self.view as! AppDetailView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = AppDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationController()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationItem.largeTitleDisplayMode = .never
        addHeaderViewController()
        addDelimiterView(topAnchor: headerViewController.view.bottomAnchor)
        addVersionViewController()
        addDelimiterView(topAnchor: versionVC.view.bottomAnchor)
        addScreenshotViewController()
    }
    
    private func addDelimiterView(topAnchor:  NSLayoutYAxisAnchor) {
        let delimiter = DelimiterView()
        self.view.addSubview(delimiter)
        delimiter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            delimiter.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            delimiter.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            delimiter.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            delimiter.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func addHeaderViewController() {
        self.addChild(headerViewController)
        self.view.addSubview(headerViewController.view)
        headerViewController.didMove(toParent: self)
        
        headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            headerViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        ])
    }
    
    private func addVersionViewController() {
        self.addChild(versionVC)
        self.view.addSubview(versionVC.view)
        versionVC.didMove(toParent: self)
        
        versionVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            versionVC.view.topAnchor.constraint(equalTo: headerViewController.view.bottomAnchor, constant: 16),
            versionVC.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            versionVC.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            versionVC.view.heightAnchor.constraint(equalToConstant: AppDetailConstants.miniScreenshotWidth)
        ])
    }
    

    
    func getScreenshotURL(indexPath: IndexPath) -> URL {
        let urlStr = app.screenshotUrls[indexPath.row]
        let url = URL(string: urlStr)!
        return url
    }
    
    // MARK: - Private
    
    private func configureNavigationController() {
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
    }
}







//Age of Magic
