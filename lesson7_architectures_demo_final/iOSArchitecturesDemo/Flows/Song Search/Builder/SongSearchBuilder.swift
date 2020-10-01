//
//  SongSearchBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 25.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class SongSearchBuilder {
    static func build() -> (UIViewController & SongSearchViewInput) {
        let interactor = SongSearchInteractor()
        let router = SongSearchRouterInput()
        
        let presenter = SongSearchPresenter(interactor: interactor, router: router)
        let viewController = SongSearchVC(presenter: presenter)
        presenter.viewInput = viewController
        router.viewController = viewController
        return viewController
    }
}
