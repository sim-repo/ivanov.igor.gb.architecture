//
//  TaskTableViewCell.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 19.09.2020.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtaskButton: UIButton!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var subtaskCountLabel: UILabel!
    
    private weak var viewModel: TaskViewModel?
    private weak var tableView: UITableView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(task: TaskProtocol, viewModel: TaskViewModel, tableView: UITableView, subTasksCount: Int) {
        nameLabel.text = task.name
        self.viewModel = viewModel
        self.tableView = tableView
        
        if task is TaskGroupComposite {
            subtaskButton.isHidden = false
            let paperPlane = UIImage(systemName: task is TaskGroupComposite ? "folder" : "plus")
            subtaskButton.setImage(paperPlane, for: .normal)
        } else {
            subtaskButton.isHidden = true
        }
        
        if task.status == .ready {
            statusButton.setImage(UIImage(systemName: "square"), for: .normal)
        } else {
            statusButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        if subTasksCount > 0 {
            subtaskCountLabel.text = "\(subTasksCount)"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func doPressDrillDownTask(_ sender: Any) {
        guard let indexPath = tableView?.indexPath(for: self) else { return }
        viewModel?.didPressDrillDownTask = indexPath
    }
    
    @IBAction func pressStatusButton(_ sender: Any) {
        guard let indexPath = tableView?.indexPath(for: self) else { return }
        viewModel?.didPressStatus = indexPath
    }
}
