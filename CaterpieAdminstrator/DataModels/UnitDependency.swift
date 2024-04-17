//
//  UnitDependency.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 26.03.24.
//

import Foundation

struct UnitDependency: Codable{
    var unit: String
    var targetIUnit: String
    var count: Float
    var deposit: Float?
    
    init(_ fbDependency: FBUnitDependency){
        self.unit = fbDependency.unit
        self.count = Float(fbDependency.count) ?? 0.0
        self.targetIUnit = fbDependency.targetUnit
        self.deposit = fbDependency.deposit == nil ? nil : Float(fbDependency.deposit!)
        
    }
    
    init(unit: String, targetUnit: String, count: Float, deposit: Float?){
        self.unit = unit
        self.targetIUnit = targetUnit
        self.count = count
        self.deposit = deposit
    }
}

struct FBUnitDependency: Codable{
    let unit: String
    let targetUnit: String
    let count: String
    let deposit: String?
    
    
    init(_ unitDependencyIn: UnitDependency){
        self.unit = unitDependencyIn.unit
        self.targetUnit = unitDependencyIn.targetIUnit
        self.count = String(unitDependencyIn.count)
        self.deposit = unitDependencyIn.deposit == nil ? nil : String(unitDependencyIn.deposit!)
    }
}
