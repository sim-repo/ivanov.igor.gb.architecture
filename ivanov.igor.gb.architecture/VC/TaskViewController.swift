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
    weak var viewModel: TaskViewModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddTask))
        navigationItem.rightBarButtonItems = [add]
        navigationItem.title = viewModel.parentTask?.name
    }
    
    
    deinit {
        let name = viewModel?.parentTask?.name ?? ""
        print("\(TaskViewController.self): \(name) :deinit")
    }
    
    
    @objc func pressAddTask(){
       // destination = (.newTask, ["Hello", "John"])
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
        cell.setup(name: task.name, viewModel: viewModel, tableView: tableView)
        return cell
    }
}

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //destination = (.taskList, indexPath)
    }
}
