//
//  TaskGroupDecorator.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import Foundation


final class TaskGroupDecorator: TaskGroupDecoratorProtocol {
    
    var name: String
    var subtasks: [TaskProtocol]?
    
    init(name: String) {
        self.name = name
    }
    
    func addTask(subtask: TaskProtocol) {
        if subtasks == nil {
            subtasks = []
        }
        subtasks?.append(subtask)
    }
    
    func remove(task: TaskProtocol) {
        
    }
}
