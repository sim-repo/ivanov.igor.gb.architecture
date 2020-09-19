//
//  NewTaskViewController.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import UIKit

class NewTaskViewController: UIViewController,Storyboarded, CoordinatableVCProtocol {

    var viewModel: TaskViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setup(_ viewModel: TaskViewModel) {
        self.viewModel = viewModel
    }
    
    func setViewModel(_ vm: ViewModelProtocol) {
        guard let vm = vm as? TaskViewModel else { return }
        viewModel = vm
    }
}
