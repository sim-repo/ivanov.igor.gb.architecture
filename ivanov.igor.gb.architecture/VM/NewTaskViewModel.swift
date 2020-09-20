//
//  NewTaskViewModel.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 20.09.2020.
//

import Foundation


import UIKit
import Combine

class NewTaskViewModel: ViewModelProtocol {
   
    var didPressForward: Published<(ScreenEnum, Any?)>.Publisher? { nil }
    var didPressBack: Published<Any?>.Publisher? { $back }
    
    @Published var back: Any? = nil
    @Published var didPressCommitNewTask: TaskProtocol?
    
    private var cancellable = Set<AnyCancellable>()
    
    var taskViewModel: TaskViewModel?
    
    
    required init(params: Any?) {
        guard let taskVM = params as? TaskViewModel
        else { return }
        taskViewModel = taskVM
        binding()
    }
    
    
    private func binding() {
        $didPressCommitNewTask
            .dropFirst()
            .sink(receiveValue: {[weak self] newTask in
                guard let self = self,
                      let vm = self.taskViewModel,
                      let newTask = newTask
                      else { return }
                if let parentTask = vm.parentTask {
                    vm.taskService.addSubTask(parentTask: parentTask, subtask: newTask)
                } else {
                    vm.taskService.addGeneralTask(task: newTask)
                }
                self.back = true
            })
            .store(in: &cancellable)
    }
    
}
