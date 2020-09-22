//
//  CondimentDecorator.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 22.09.2020.
//

import Foundation


protocol CondimentDecorator: BeverageProtocol {
    var beverage: BeverageProtocol {get set}
}

class MilkCondiment: CondimentDecorator {

    var beverage: BeverageProtocol
    var name: String = "milk"
    var cost: Double = 0.5
    
    init(beverage: BeverageProtocol) {
        self.beverage = beverage
    }
    
    func getName() -> String {
        return "\(beverage.getName()), \(name)"
    }
    
    func getCost() -> Double {
        return beverage.getCost() + cost
    }
}


class WhipCondiment: CondimentDecorator {

    var beverage: BeverageProtocol
    var name: String = "whip"
    var cost: Double = 1.2
    
    init(beverage: BeverageProtocol) {
        self.beverage = beverage
    }
    
    func getName() -> String {
        return "\(beverage.getName()), \(name)"
    }
    
    func getCost() -> Double {
        return cost + beverage.getCost()
    }
}


class SugarCondiment: CondimentDecorator {

    var beverage: BeverageProtocol
    var name: String = "sugar"
    var cost: Double = 0.3
    
    init(beverage: BeverageProtocol) {
        self.beverage = beverage
    }
    
    func getName() -> String {
        return "\(beverage.getName()), \(name)"
    }
    
    func getCost() -> Double {
        return cost + beverage.getCost()
    }
}
