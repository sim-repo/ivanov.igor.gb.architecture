//
//  TaskViewModel.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import UIKit
import Combine

class TaskViewModel: ViewModelProtocol {
    
    private var parentTask: TaskProtocol?
    
    required init(params: Any?) {
        guard let param = params as? TaskProtocol else { return }
        parentTask = param
    }
    
    @Published var taskList: [TaskProtocol] = [Task(name: "1"),
                                               Task(name: "2"),
                                               TaskGroupDecorator(name: "3"),
                                               Task(name: "4"),
                                               Task(name: "5")]
    
    //input
    @Published var commitNewTask: TaskProtocol?
    
}
