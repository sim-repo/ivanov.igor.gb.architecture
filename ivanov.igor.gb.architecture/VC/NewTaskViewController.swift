//
//  NewTaskViewController.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 18.09.2020.
//

import UIKit

class NewTaskViewController: UIViewController, Storyboarded, CoordinatableVCProtocol {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var viewModel: NewTaskViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupOutlets()
        setupNavigationBar()
    }

    func setup(_ viewModel: NewTaskViewModel) {
        self.viewModel = viewModel
    }
    
    func setViewModel(_ vm: ViewModelProtocol) {
        guard let vm = vm as? NewTaskViewModel else { return }
        viewModel = vm
    }
    
    private func setupNavigationBar() {
        navigationItem.title = viewModel.taskViewModel?.parentTask?.name ?? ""
    }
    
    private func setupOutlets(){
        descTextView.text = "Additional Description"
        descTextView.textColor = UIColor.lightGray
    }
    
    
    @IBAction func doPressSubmit(_ sender: Any) {
        guard let title = titleTextField.text,
              !title.isEmpty
        else { return }
        
        let builder = TaskBuilder()
        builder.setName(title)
        builder.setDesc(descTextView.text)
        if segmentControl.selectedSegmentIndex == 0 {
            builder.setType(type: .single)
        } else if segmentControl.selectedSegmentIndex == 1 {
            builder.setType(type: .group)
        }
        guard let task = builder.build() else { return }
        viewModel.didPressCommitNewTask = task
        navigationController?.popViewController(animated: true)
    }
}

extension NewTaskViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descTextView.textColor == UIColor.lightGray {
            descTextView.text = nil
            descTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descTextView.text.isEmpty {
            setupOutlets()
        }
    }
}


