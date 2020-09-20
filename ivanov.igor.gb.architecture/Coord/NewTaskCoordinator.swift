//
//  NewTaskCoordinator.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import UIKit
import Combine


class NewTaskCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol]?
    
    var vc: (UIViewController & CoordinatableVCProtocol)?
    var viewModel: NewTaskViewModel?
    
    var onRelease: (()->Void)?
    var navigationController: UINavigationController
    private var params: Any?
    private var cancellable = Set<AnyCancellable>()
    
    
    required init(navigationController: UINavigationController, params: Any?) {
        self.navigationController = navigationController
        self.params = params
    }
    
    deinit {
        print("NewTaskCoordinator: deinit")
    }
    
    func start(onRelease: (()->Void)? = nil) {
        self.onRelease = onRelease
        vc = NewTaskViewController.instantiate(storyboardName: "Main")
        viewModel = NewTaskViewModel(params: params)
        binding()
        vc?.setViewModel(viewModel!)
        navigationController.pushViewController(vc!, animated: true)
    }
    
    func binding(){
        viewModel?.didPressBack?
        .dropFirst()
        .sink(receiveValue: {[weak self] _ in
            guard let self = self else { return }
            self.doBack()
        })
        .store(in: &cancellable)
    }
    
    func doForward(screenEnum: ScreenEnum, params: Any?) {
    }
    
    func doBack() {
        onRelease?()
    }
}




