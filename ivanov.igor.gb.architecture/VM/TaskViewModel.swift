//
//  TaskViewModel.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import UIKit
import Combine

class TaskViewModel: ViewModelProtocol {
    
    private (set) var taskService: TaskService
    private(set) var parentTask: TaskGroupCompositeProtocol?
    private var cancellable = Set<AnyCancellable>()
 
    
    //input
    @Published var didPressNewTask: Any?
    @Published var didPressDrillDownTask: IndexPath?
    @Published var didPressStatus: IndexPath?
    @Published var needReloadData: Any?
    @Published var didSwipeRemoveTask: IndexPath?
    
    //output
    @Published var destination: (ScreenEnum, Any?) = (.none,nil)
    @Published var back: Any? = nil
    @Published var taskList: [TaskProtocol] = []
    var didPressForward: Published<(ScreenEnum, Any?)>.Publisher? { $destination }
    var didPressBack: Published<Any?>.Publisher? { $back }
    
    
    required init(params: Any?) {
        if let param = params as? TaskGroupCompositeProtocol {
            parentTask = param
            taskService = TaskService(parentTask)
        }
        else {
            taskService = TaskService()
        }
        binding()
    }
    
    
    deinit {
        print("\(TaskViewModel.self): deinit")
    }
    
    
    private func binding() {
        taskService.$taskList
            .sink(receiveValue: {[weak self] list in
                guard let self = self else { return }
                self.taskList = list
                self.needReloadData = true
            })
            .store(in: &cancellable)
        
        
        $didPressDrillDownTask
            .dropFirst()
            .sink(receiveValue: {[weak self] indexPath in
                guard let self = self,
                    let indexPath = indexPath,
                    let curTask = self.getCurrentTask(taskList: self.taskList, indexPath: indexPath)
                    else { return }
                self.destination = (.taskList, curTask)
            })
            .store(in: &cancellable)
        
        $didPressStatus
            .dropFirst()
            .sink(receiveValue: {[weak self] indexPath in
                guard let self = self,
                    let indexPath = indexPath,
                    let curTask = self.getCurrentTask(taskList: self.taskList, indexPath: indexPath)
                    else { return }
                var status: TaskStatusType = .ready
                if curTask.status == .ready {
                    status = .done
                }
                self.taskService.changeStatus(status: status, subtask: curTask)
                self.needReloadData = true
            })
            .store(in: &cancellable)
        
        $didPressNewTask
            .dropFirst()
            .sink(receiveValue: {[weak self] _ in
                guard let self = self else { return }
                self.destination = (.newTask, self)
            })
            .store(in: &cancellable)
        
        $didSwipeRemoveTask
            .dropFirst()
            .sink(receiveValue: {[weak self] indexPath in
                guard let self = self,
                    let indexPath = indexPath,
                    let curTask = self.getCurrentTask(taskList: self.taskList, indexPath: indexPath)
                    else { return }
                self.taskService.remove(parentTask: self.parentTask, subtask: curTask)
            })
            .store(in: &cancellable)
    }
    
    public func getSubTasksCount(at indexPath: IndexPath) -> Int {
        guard let curTask = self.getCurrentTask(taskList: self.taskList, indexPath: indexPath) else { return 0}
        return taskService.getSubTaskCount(subtask: curTask)
    }
    
    private func getCurrentTask(taskList: [TaskProtocol]?, indexPath: IndexPath) -> TaskProtocol? {
        guard let list = taskList,
                 list.count - 1 >= indexPath.row
        else { return nil }
        return list[indexPath.row]
    }
}
