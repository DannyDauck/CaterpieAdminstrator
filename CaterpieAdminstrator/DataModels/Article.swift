//
//  Article.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 26.03.24.
//

import Foundation

struct Article: Codable{
    
    var ean: String
    var name: String
    var manufactorer: String
    var ingredients: [String]
    var units: [UnitDependency]
    var alternativProducts: [String]
    var isForecasteArticle: Bool
    var category: String
    
    init(ean: String, name: String, manufactorer: String, ingredients: [String], units: [UnitDependency], alternativProducts: [String], isForecasteArticle: Bool, category: String) {
        self.ean = ean
        self.name = name
        self.manufactorer = manufactorer
        self.ingredients = ingredients
        self.units = units
        self.alternativProducts = alternativProducts
        self.isForecasteArticle = isForecasteArticle
        self.category = category
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ean = try container.decode(String.self, forKey: .ean)
        self.name = try container.decode(String.self, forKey: .name)
        self.manufactorer = try container.decode(String.self, forKey: .manufactorer)
        self.ingredients = try container.decode([String].self, forKey: .ingredients)
        self.units = try container.decode([UnitDependency].self, forKey: .units)
        self.alternativProducts = try container.decode([String].self, forKey: .alternativProducts)
        self.isForecasteArticle = try container.decode(Bool.self, forKey: .isForecasteArticle)
        self.category = try container.decode(String.self, forKey: .category)
    }
    init(_ fbArticle: FBArticle){
        self.ean = fbArticle.ean
        self.name = fbArticle.name
        self.manufactorer = fbArticle.manufactorer
        self.ingredients = fbArticle.ingredients
        self.units = []
        self.alternativProducts = fbArticle.alternativProducts
        self.isForecasteArticle = fbArticle.isForecasteArticle
        self.category = fbArticle.category
    }
}

struct FBArticle: Codable{
    let ean: String
    let name: String
    let manufactorer: String
    let ingredients: [String]
    var units: [FBUnitDependency]
    let alternativProducts: [String]
    let isForecasteArticle: Bool
    var category: String
    
    init(_ articleIn: Article){
        self.ean = articleIn.ean
        self.name = articleIn.name
        self.manufactorer = articleIn.manufactorer
        self.ingredients = articleIn.ingredients
        self.units = []
        for unit in articleIn.units{
            self.units.append(FBUnitDependency(unit))
        }
        self.alternativProducts = articleIn.alternativProducts
        self.isForecasteArticle = articleIn.isForecasteArticle
        self.category = articleIn.category
    }
}
