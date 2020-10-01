//
//  MenuBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 25.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class MenuBuilder {
    static func build() -> MenuViewController {
        let presenter = MenuPresenter()
        let viewController = MenuViewController(presenter: presenter)
        presenter.setup(with: viewController)
        
        var batman = Detective(fullName: "Bruce Wayne")
        batman.fullName = "Jo"
        print(batman.fullName) // returns “Bruce Wayne”
        
        return viewController
    }
}


protocol FullyNamed {
 var fullName: String { get set }
}
struct Detective: FullyNamed {
 var fullName: String = "Super"
}

