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
        print("TaskCoordinator: deinit")
    }
    
    func start(onRelease: (()->Void)? = nil) {
        self.onRelease = onRelease
        
        let factory = ViewControllerFactory()
        vc = factory.create(screenEnum: .taskList)
        
        vc = TaskViewController.instantiate(storyboardName: "Main")
        viewModel = TaskViewModel(params: params)
        binding()
        vc?.setViewModel(viewModel!)
        navigationController.pushViewController(vc!, animated: true)
    }
    
    
    func binding(){
        viewModel?.didPressForward?
        .dropFirst()
        .sink(receiveValue: {[weak self] (val) in
            guard let self = self else { return }
            let screenEnum = val.0
            let params = val.1
            self.doForward(screenEnum: screenEnum, params: params)
        })
        .store(in: &cancellable)
        
        
        viewModel?.didPressBack?
        .dropFirst()
        .sink(receiveValue: {[weak self] _ in
            guard let self = self else { return }
            self.doBack()
        })
        .store(in: &cancellable)
    }
    
    
    func doForward(screenEnum: ScreenEnum, params: Any?) {
        var coord: CoordinatorProtocol
        switch screenEnum {
        case .taskList:
            coord = TaskCoordinator(navigationController: navigationController, params: params)
        case .newTask:
            coord = NewTaskCoordinator(navigationController: navigationController, params: params)
        default:
            return
        }
        store(coordinator: coord)
        coord.start(onRelease: { [weak self] in
            guard let self = self else { return }
            self.free(coordinator: coord)
            self.viewModel?.needReloadData = true
        })
    }
    
    func doBack() {
        onRelease?()
    }
}

