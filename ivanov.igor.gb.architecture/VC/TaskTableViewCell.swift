//
//  TaskTableViewCell.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 19.09.2020.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    private weak var viewModel: TaskViewModel?
    private weak var tableView: UITableView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(name: String, viewModel: TaskViewModel, tableView: UITableView) {
        nameLabel.text = name
        self.viewModel = viewModel
        self.tableView = tableView
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func doPressDrillDownTask(_ sender: Any) {
        guard let indexPath = tableView?.indexPath(for: self) else { return }
        viewModel?.didPressDrillDownTask = indexPath
    }
    
}
