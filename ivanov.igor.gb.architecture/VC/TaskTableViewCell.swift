//
//  TaskTableViewCell.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 19.09.2020.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    private weak var vc: TaskViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(name: String, vc: TaskViewController) {
        nameLabel.text = name
        self.vc = vc
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func doPressShowChildTasks(_ sender: Any) {
        vc?.cellDidPressShowChildTasks = self
    }
    
}
