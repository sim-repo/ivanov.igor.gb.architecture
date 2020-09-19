//
//  TaskDecorator.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import Foundation

// #composite
protocol TaskGroupDecoratorProtocol: TaskProtocol {
    var subtasks: [TaskProtocol]? { get }
    func addTask(subtask: TaskProtocol)
    func remove(task: TaskProtocol)
}
