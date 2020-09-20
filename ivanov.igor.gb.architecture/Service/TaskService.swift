//
//  TaskService.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 20.09.2020.
//

import Foundation
import Combine

class TaskService {
    
    public var parentTask: TaskGroupCompositeProtocol?
    @Published var taskList: [TaskProtocol] = []
    
    init(_ parentTask: TaskGroupCompositeProtocol? = nil){
        self.parentTask = parentTask
        if let _ = parentTask {
            setupWithSubTasks()
            return
        }
        setupWithGeneralTasks()
    }
    
    
    private func setupWithGeneralTasks() {
        taskList = [Task(name: "Убрать квартиру"),
                    Task(name: "Сготовить обед"),
                    TaskGroupComposite(name: "Сходить в магазин"),
                    Task(name: "Отремонитировать лампу"),
                    Task(name: "Покормить кота"),
                    TaskGroupComposite(name: "Доработать")
                    ]
    }
    
    private func setupWithSubTasks() {
        taskList = getSubTasks(parentTask: parentTask!)
    }
    
    public func getSubTasks(parentTask: TaskGroupCompositeProtocol) -> [TaskProtocol] {
        guard let subTasks = parentTask.subtasks
        else { return [] }
        return subTasks
    }
    
    public func getSubTaskCount(subtask: TaskProtocol) -> Int {
        guard let task = subtask as? TaskGroupCompositeProtocol
        else { return 0 }
        guard let subTasks = task.subtasks
        else { return 0 }
        return subTasks.count
    }
    
    public func addGeneralTask(task: TaskProtocol){
        var list = taskList
        list.append(task)
        taskList = list
    }
    
    public func addSubTask(parentTask: TaskGroupCompositeProtocol, subtask: TaskProtocol) {
        parentTask.addTask(subtask: subtask)
        var list = taskList
        list.append(subtask)
        taskList = list
    }
    
    public func remove(parentTask: TaskGroupCompositeProtocol?, subtask: TaskProtocol) {
        guard let parentTask = parentTask else {
            var list = taskList
            if let index = list.firstIndex(where: {$0 === subtask}) {
                list.remove(at: index)
            }
            taskList = list
            return
        }
        parentTask.remove(task: subtask)
    }
    
    public func getGeneralTasks() ->  [TaskProtocol] {
        return taskList
    }
    
    public func changeStatus(status: TaskStatusType, subtask: TaskProtocol){
        subtask.setStatus(status: status)
    }
    

}
