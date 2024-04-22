//
//  Table.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 22.04.24.
//

import Foundation


struct Table: Codable{
    
    var number: String
    var orders: [Order]
    var sum: String{
        var newSum: Float = 0.0
        for order in orders {
                if let price = Float(order.price) {
                    newSum += price
                }
            }
        return String(newSum)
    }
    
}
