//
//  TaskViewModel.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import UIKit
import Combine

class TaskViewModel: ViewModelProtocol {
    
    private(set) var parentTask: TaskProtocol?
    private var cancellable = Set<AnyCancellable>()
    
    @Published var destination: (ScreenEnum, Any?) = (.none,nil)

    
    @Published var didPressDrillDownTask: IndexPath?

    @Published var taskList: [TaskProtocol] = [Task(name: "1"),
                                               Task(name: "2"),
                                               TaskGroupDecorator(name: "3"),
                                               Task(name: "4"),
                                               Task(name: "5")]
    
    //input
    @Published var commitNewTask: TaskProtocol?
    
    //output
    var didPressForward: Published<(ScreenEnum, Any?)>.Publisher? { $destination }
    var didPressBack: Published<Bool> = .init(initialValue: true)
    
    
    
    required init(params: Any?) {
        binding()
        guard let param = params as? TaskProtocol else { return }
        parentTask = param
    }
    
    
    deinit {
        print("\(TaskViewModel.self): deinit")
    }
    
    
    private func binding() {
        $didPressDrillDownTask
            .sink(receiveValue: {[weak self] indexPath in
                guard let self = self,
                    let indexPath = indexPath,
                    let curTask = self.getCurrentTask(taskList: self.taskList, indexPath: indexPath)
                    else { return }
                self.destination = (.taskList, curTask)
            })
            .store(in: &cancellable)
    }
    
    
    private func getCurrentTask(taskList: [TaskProtocol]?, indexPath: IndexPath) -> TaskProtocol? {
        guard let list = taskList,
                 list.count - 1 >= indexPath.row
        else { return nil }
        return list[indexPath.row]
    }
}
