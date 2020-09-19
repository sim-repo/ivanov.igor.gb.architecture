//
//  Task.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import Foundation


enum TaskStatusType {
    case ready, pending, done, canceled
}

protocol TaskProtocol: class {
    var name: String { get set }
    init(name: String)
}

final class Task: TaskProtocol {
    var name: String
    var status: TaskStatusType = .ready

    init(name: String){
        self.name = name
    }
}
