//
//  BeverageBuilder.swift
//  ivanov.igor.gb.architecture
//
//  Created by Igor Ivanov on 22.09.2020.
//

import Foundation


public final class BeverageBuilder {
    
    private var milkQty: Int = 0
    private var whipQty: Int = 0
    private var sugarQty: Int  = 0
    private var type: BeverageType = .none
    
    public init(type: BeverageType) {
        self.type = type
    }
    
    public func addMilk() {
        milkQty += 1
    }
    
    public func removeMilk() {
        milkQty -= 1
    }
    
    public func addWhip() {
        whipQty += 1
    }
    
    public func removeWhip() {
        whipQty -= 1
    }
    
    public func addSugar() {
        sugarQty += 1
    }
    
    public func removeSugar() {
        sugarQty -= 1
    }
    
    public func build() -> BeverageProtocol {
        var beverage: BeverageProtocol!
        
        switch type {
            case .darkRoast:
                beverage = DarkRoast()
            case .decaf:
                beverage = Decaf()
            case .expresso:
                beverage = Espresso()
            case .houseBlend:
                beverage = HouseBlend()
            default:
                break
        }
        
        if milkQty > 0 {
            for _ in 0..<milkQty {
                beverage = MilkCondiment(beverage: beverage)
            }
        }
        
        if whipQty > 0 {
            for _ in 0..<whipQty {
                beverage = WhipCondiment(beverage: beverage)
            }
        }
        
        if sugarQty > 0 {
            for _ in 0..<sugarQty {
                beverage = SugarCondiment(beverage: beverage)
            }
        }
        return beverage
    }
}
