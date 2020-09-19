//
//  TaskViewController.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import UIKit
import Combine

class TaskViewController: UIViewController, Storyboarded, CoordinatableVCProtocol {
      
    @IBOutlet weak var tableView: UITableView!
    var viewModel: TaskViewModel!
    
    
    @Published var cellDidPressShowChildTasks: UITableViewCell?
    @Published var destination: (ScreenEnum, Any?) = (.newTask,"Hello")
    @Published var params: Any?
        
        
    var didPressForward: Published<(ScreenEnum, Any?)>.Publisher? { $destination }
    var didPressBack: Published<Bool> = .init(initialValue: true)
    private var cancellable = Set<AnyCancellable>()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddTask))
        navigationItem.rightBarButtonItems = [add]
        navigationItem.title = "Task List"
        binding()
    }
    
    @objc func pressAddTask(){
        destination = (.newTask, ["Hello", "John"])
    }
    
    func setViewModel(_ vm: ViewModelProtocol) {
        guard let vm = vm as? TaskViewModel else { return }
        viewModel = vm
    }
    

}


extension TaskViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        let task = viewModel.taskList[indexPath.row]
        cell.setup(name: task.name, vc: self)
        return cell
    }
}

// table cell
extension TaskViewController {
    
    func binding(){
        $cellDidPressShowChildTasks
            .sink(receiveValue: {[weak self] cell in
                guard let self = self,
                      let cell = cell else { return }
                if let idx = self.tableView.indexPath(for: (cell)) {
                    self.destination = (.taskList, idx.row)
                }
            })
            .store(in: &cancellable)
    }
}

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        destination = (.taskList, indexPath)
    }
}
