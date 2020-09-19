//
//  NewTaskViewController.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import UIKit

class NewTaskViewController: UIViewController,Storyboarded, CoordinatableVCProtocol {


    @Published var destination: (ScreenEnum, Any?) = (.newTask,nil)
    @Published var params: Any?
        
        
    var didPressForward: Published<(ScreenEnum, Any?)>.Publisher? { $destination }
    var didPressBack: Published<Bool> = .init(initialValue: true)
    

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
