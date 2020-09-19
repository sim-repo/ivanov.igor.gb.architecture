//
//  ScreenFactory.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 19.09.2020.
//

import UIKit
import Combine


protocol ViewModelProtocol {
    init(params: Any?)
}

protocol CoordinatableVCProtocol: class {
    var didPressForward: Published<(ScreenEnum,Any?)>.Publisher? { get }
    var didPressBack: Published<Bool> { get set }
    func setViewModel(_ vm: ViewModelProtocol)
}



class ViewControllerFactory {
    func create(screenEnum: ScreenEnum) -> (UIViewController & CoordinatableVCProtocol)? {
        switch screenEnum {
        case .taskList:
            return TaskViewController.instantiate(storyboardName: "Main")
        case .newTask:
            return NewTaskViewController.instantiate(storyboardName: "Main")
        }
    }
}
