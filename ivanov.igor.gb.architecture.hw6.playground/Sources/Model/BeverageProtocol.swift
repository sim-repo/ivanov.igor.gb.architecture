
import Foundation

public protocol BeverageProtocol {
    var name: String { get set }
    var cost: Double { get set }
    
    func getName() -> String
    func getCost() -> Double
}

extension BeverageProtocol {
    
    func getName() -> String {
        return name
    }
    
    public func getCost() -> Double {
        return cost
    }
}


final class HouseBlend: BeverageProtocol {
    var name: String = "house blend"
    var cost: Double = 2
}


final class DarkRoast: BeverageProtocol {
    var name: String = "dark roast"
    var cost: Double = 3
}

final class Espresso: BeverageProtocol {
    var name: String = "espresso"
    var cost: Double = 4
}


final class Decaf: BeverageProtocol {
    var name: String = "decaf"
    var cost: Double = 5
}


