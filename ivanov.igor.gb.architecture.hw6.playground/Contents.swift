import UIKit

let builder = BeverageBuilder(type: .expresso)
builder.addMilk()
builder.addWhip()
builder.addSugar()
builder.addMilk()
let beverage = builder.build()
print(beverage.getName())
print(beverage.getCost())
