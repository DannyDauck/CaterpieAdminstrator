//
//  Product.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 20.04.24.
//

import Foundation


struct Product: Codable{
    
    var name: String
    var plu: Int
    var articleDependencies: [ArticleDependency]
    var tags: [String]
    var flavours: [Product] = []
    var price: String
    var category: String
    
    
}
