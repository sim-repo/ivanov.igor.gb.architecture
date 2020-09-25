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
        let presenter = SongSearchPresenter()
        let viewController = SongSearchVC(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
