//
//  Task.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import Foundation


protocol TaskProtocol: class {
    var name: String { get set }
    var desc: String? { get set }
    var status: TaskStatusType { get set }
    init(name: String)
    func setStatus(status: TaskStatusType)
}

final class Task: TaskProtocol {
    var name: String
    var desc: String?
    var status: TaskStatusType = .ready

    init(name: String){
        self.name = name
    }
    
    func setStatus(status: TaskStatusType) {
        self.status = status
    }
}
