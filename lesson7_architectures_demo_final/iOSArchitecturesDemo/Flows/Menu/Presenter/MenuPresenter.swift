//
//  MenuPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 25.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit


protocol MenuViewOutput {
    func viewDidSelectMenuItem(menuItem: MenuPresenter.MenuItem)
}

protocol MenuViewInput {
}


class MenuPresenter {
    enum MenuItem {
        case app, song
    }
    weak var viewInput: (UIViewController & MenuViewInput)?

    func setup(with viewInput: (UIViewController & MenuViewInput)) {
        self.viewInput = viewInput
    }
}

extension MenuPresenter: MenuViewOutput {
    func viewDidSelectMenuItem(menuItem: MenuPresenter.MenuItem) {
        switch menuItem {
        case .app:
            let vc = AppSearchBuilder.build()
            viewInput?.navigationController?.pushViewController(vc, animated: true)
        case .song:
            let vc = SongSearchBuilder.build()
            viewInput?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
