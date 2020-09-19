//
//  TaskCoordinator.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import UIKit
import Combine

class TaskCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol]?
    
    var vc: (UIViewController & CoordinatableVCProtocol)?
    var viewModel: TaskViewModel?
    
    var onRelease: (()->Void)?
    var navigationController: UINavigationController
    
    private var params: Any?
    
    private var cancellable = Set<AnyCancellable>()
    
    required init(navigationController: UINavigationController, params: Any?) {
        self.navigationController = navigationController
        self.params = params
    }
    
    deinit {
        print("deinit")
    }
    
    func start(onRelease: (()->Void)? = nil) {
        self.onRelease = onRelease
        
        let factory = ViewControllerFactory()
        vc = factory.create(screenEnum: .taskList)
        
        vc = TaskViewController.instantiate(storyboardName: "Main")
        viewModel = TaskViewModel(params: params)
        binding()
        vc?.setViewModel(viewModel!)
        navigationController.pushViewController(vc!, animated: false)
    }
    
    
    func binding(){
        vc?.didPressForward?.sink(receiveValue: {(val) in
            print("\(val.0) : \(val.1)")
        })
        .store(in: &cancellable)
    }
    
    
    func didPressForward(screenEnum: ScreenEnum) {
        var coord: CoordinatorProtocol
        switch screenEnum {
        case .taskList:
            coord = TaskCoordinator(navigationController: navigationController, params: params)
        case .newTask:
            coord = NewTaskCoordinator(navigationController: navigationController, params: params)
        }
        store(coordinator: coord)
        coord.start(onRelease: { [weak self] in
            self?.free(coordinator: coord)
        })
    }
    
    func didPressBack() {
        onRelease?()
    }
}

