//
//  NewTaskCoordinator.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import UIKit


class NewTaskCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol]?
    
    var vc: (UIViewController & CoordinatableVCProtocol)?
    var viewModel: TaskViewModel?
    
    var onRelease: (()->Void)?
    var navigationController: UINavigationController
    private var params: Any?
    
    required init(navigationController: UINavigationController, params: Any?) {
        self.navigationController = navigationController
        self.params = params
    }
    
    func start(onRelease: (()->Void)? = nil) {
        self.onRelease = onRelease
        vc = TaskViewController.instantiate(storyboardName: "NewTask")
        viewModel = TaskViewModel(params: params)
        vc?.setViewModel(viewModel!)
        navigationController.pushViewController(vc!, animated: false)
    }
    
    func doForward(screenEnum: ScreenEnum, params: Any?) {
    }
    
    func doBack() {
        onRelease?()
    }
}




