//
//  TaskBuilder.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 20.09.2020.
//

import Foundation


class TaskBuilder {
    
    private var curTask: TaskProtocol?
    private var name: String?
    private var desc: String?
    private var type: TaskType = .single
    
    enum TaskType {
        case single, group
    }
    
    public func setName(_ name: String) {
        self.name = name
    }
    
    public func setDesc(_ desc: String) {
        self.desc = desc
    }
    
    public func setType(type: TaskBuilder.TaskType) {
        self.type = type
    }
    
    public func build() -> TaskProtocol? {
        guard let name = name else { return nil }
        switch type {
        case .single:
            let task = Task(name: name)
            task.desc = desc
            return task
        case .group:
            let task = TaskGroupComposite(name: name)
            task.desc = desc
            return task
        }
    }
}
