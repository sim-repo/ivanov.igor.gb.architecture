//
//  MenuVC.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 25.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

final class MenuViewController: UIViewController {
    
    var presenter: MenuViewOutput
    private var appMenuButton: UIButton!
    
    
    init(presenter: MenuViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        addAppMenuItem()
        addSongMenuItem()
    }
    
    
    func addAppMenuItem() {
        appMenuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        appMenuButton.translatesAutoresizingMaskIntoConstraints = false
        appMenuButton.backgroundColor = .gray
        appMenuButton.setTitle("Apps", for: .normal)
        appMenuButton.addTarget(self, action: #selector(pressAppMenuItem), for: .touchUpInside)
        self.view.addSubview(appMenuButton)
        NSLayoutConstraint.activate([
            appMenuButton.widthAnchor.constraint(equalToConstant: 300),
            appMenuButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            appMenuButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            appMenuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
    
    func addSongMenuItem() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("Music", for: .normal)
        button.addTarget(self, action: #selector(pressSongMenuItem), for: .touchUpInside)
        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 300),
            button.topAnchor.constraint(equalTo: appMenuButton.bottomAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
    
    @objc func pressAppMenuItem() {
        presenter.viewDidSelectMenuItem(menuItem: .app)
    }
    
    @objc func pressSongMenuItem() {
        presenter.viewDidSelectMenuItem(menuItem: .song)
    }
}


extension MenuViewController: MenuViewInput {
}
