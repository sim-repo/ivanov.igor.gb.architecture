//
//  TaskDecorator.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import Foundation

// #composite
protocol TaskGroupCompositeProtocol: TaskProtocol {
    var subtasks: [TaskProtocol]? { get }
    func addTask(subtask: TaskProtocol)
    func setStatus(status: TaskStatusType)
    func remove(task: TaskProtocol)
}
