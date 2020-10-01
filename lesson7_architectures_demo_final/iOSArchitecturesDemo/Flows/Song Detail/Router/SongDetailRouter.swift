//
//  SongDetailRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 30.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

protocol SongDetailRouterInputProtocol {
    func back()
}

final class SongDetailRouterInput: SongDetailRouterInputProtocol {
    weak var viewController: UIViewController?
    
    func back() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

