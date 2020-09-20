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

    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    deinit {
        let name = viewModel?.parentTask?.name ?? ""
        print("\(TaskViewController.self): \(name) :deinit")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            viewModel.back = true
        }
    }
    
    func setViewModel(_ vm: ViewModelProtocol) {
        guard let vm = vm as? TaskViewModel else { return }
        viewModel = vm
        binding()
    }
    
    private func setupNavigationBar() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddTask))
        navigationItem.rightBarButtonItems = [add]
        navigationItem.title = viewModel.parentTask?.name ?? "Tasks"
    }
    
    private func binding(){
        viewModel.$needReloadData
            .dropFirst()
            .sink(receiveValue: {[weak self] _ in
                guard let self = self else { return }
                self.tableView?.reloadData()
            })
            .store(in: &cancellable)
    }
    
    
    @objc func pressAddTask(){
        viewModel.didPressNewTask = 1
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
        let count = viewModel.getSubTasksCount(at: indexPath)
        cell.setup(task: task, viewModel: viewModel, tableView: tableView, subTasksCount: count)
        return cell
    }
}

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //destination = (.taskList, indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tableView.beginUpdates()
            viewModel.didSwipeRemoveTask = indexPath
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
}
