//
//  TaskGroupDecorator.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import Foundation


final class TaskGroupComposite: TaskGroupCompositeProtocol {
    
    var name: String
    var desc: String?
    var subtasks: [TaskProtocol]?
    var status: TaskStatusType = .ready
    
    init(name: String) {
        self.name = name
    }
    
    func addTask(subtask: TaskProtocol) {
        if subtasks == nil {
            subtasks = []
        }
        subtasks?.append(subtask)
    }
    
    func setStatus(status: TaskStatusType) {
        self.status = status
        subtasks?.forEach{$0.setStatus(status: status)}
    }
    
    func remove(task: TaskProtocol) {
        if let index = subtasks?.firstIndex(where: {$0 === task}) {
            subtasks?.remove(at: index)
        }
    }
}
