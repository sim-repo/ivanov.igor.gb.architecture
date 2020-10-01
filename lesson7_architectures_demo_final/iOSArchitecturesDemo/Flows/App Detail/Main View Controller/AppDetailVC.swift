//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailVC: UIViewController {
    
    
    let presenter: AppDetailOutput
    var app: ITunesApp
    
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView = UIStackView()
    lazy var headerViewController = AppDetailHeaderVC(app: app)
    lazy var versionVC = VersionAppDetailVC(app: app)
    lazy var descVC = DescAppDetailVC(app: app)
    var screenshotCollectionView: UICollectionView?
    
    
    init(presenter: AppDetailOutput, app: ITunesApp) {
        self.presenter = presenter
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
        
        setupScrollView()
        setupStackView()
        
        //modules:
        addHeaderViewController(topAnchor: view.safeAreaLayoutGuide.topAnchor)
        addDelimiterView(topAnchor: headerViewController.view.bottomAnchor)
        addDescViewController(topAnchor: headerViewController.view.bottomAnchor)
        
        addDelimiterView(topAnchor: descVC.view.bottomAnchor)
        addVersionViewController(topAnchor: descVC.view.bottomAnchor)
        
        addDelimiterView(topAnchor: versionVC.view.bottomAnchor)
        addScreenshotViewController(topAnchor: versionVC.view.bottomAnchor)
    }
    
    
    private func setupScrollView() {
    
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    private func setupStackView() {
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30;
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true;
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true;
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true;
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true;
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true;
    }
    
    
    private func addDelimiterView(topAnchor:  NSLayoutYAxisAnchor) {
        
        let delimiter = DelimiterView()
        stackView.addArrangedSubview(delimiter)
        delimiter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            delimiter.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            delimiter.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            delimiter.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    
    private func addHeaderViewController(topAnchor:  NSLayoutYAxisAnchor) {
        self.addChild(headerViewController)
        stackView.addArrangedSubview(headerViewController.view)
        headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        headerViewController.didMove(toParent: self)
    }
    
    
    private func addDescViewController(topAnchor:  NSLayoutYAxisAnchor) {
        self.addChild(descVC)
        stackView.addArrangedSubview(descVC.view)
        descVC.view.translatesAutoresizingMaskIntoConstraints = false
        descVC.didMove(toParent: self)
        NSLayoutConstraint.activate([
            descVC.view.leftAnchor.constraint(equalTo: self.stackView.leftAnchor),
            descVC.view.rightAnchor.constraint(equalTo: self.stackView.rightAnchor),
            descVC.view.heightAnchor.constraint(equalToConstant: descVC.preferredHeight())
        ])
    }
    
    
    private func addVersionViewController(topAnchor:  NSLayoutYAxisAnchor) {
        self.addChild(versionVC)
        stackView.addArrangedSubview(versionVC.view)
        versionVC.didMove(toParent: self)
        
        versionVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            versionVC.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            versionVC.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            versionVC.view.heightAnchor.constraint(equalToConstant: versionVC.preferredHeight())
        ])
    }
    
    
    func getScreenshotURL(indexPath: IndexPath) -> URL {
        let urlStr = app.screenshotUrls[indexPath.row]
        let url = URL(string: urlStr)!
        return url
    }
    
    
    private func configureNavigationController() {
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
    }
}
