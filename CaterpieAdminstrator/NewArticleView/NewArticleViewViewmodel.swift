//
//  NewArticleViewViewmodel.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 25.03.24.
//

import Foundation


class NewArticleViewViewmodel: ObservableObject{
    
    @Published var ean: String
    @Published var name: String = ""
    @Published var ingredients: [String] = []
    @Published var currentIngredient: String = ""
    @Published var manufactorer: String = ""
    @Published var alternitiveProducts: [String] = []
    @Published var currentAlternativeProduct: String = ""
    @Published var units: [UnitDependency]
    @Published var currentUnit: Units = .bottle
    @Published var targetUnit: Units = .milliliter
    @Published var currentUnitCount: Float = 0.0
    @Published var currentDeposit: Float = 0.0
    @Published var unitWarningIsVisible = false
    @Published var orderUnit: Units = .draft
    @Published var isForecasteInventory = false
    @Published var category = ""
    
    init(ean: String) {
        self.ean = ean
        self.name = ""
        self.ingredients = []
        self.currentIngredient = ""
        self.manufactorer = ""
        self.alternitiveProducts = []
        self.currentAlternativeProduct = ""
        self.units = []
        self.currentUnit = .bottle
        self.currentUnitCount = 0.0
        self.currentDeposit = 0.0
    }
    
    func createUnitDependency(){
        if units.isEmpty && !targetUnit.isACalculatableValue(){
            unitWarningIsVisible = true
        }else{
            let newUnitDepency = UnitDependency(unit: currentUnit.tag(), targetUnit: targetUnit.tag(), count: currentUnitCount, deposit: currentDeposit == 0.0 ? nil : currentDeposit)
            units.append(newUnitDepency)
            currentUnitCount = 0.0
            currentDeposit = 0.0
            unitWarningIsVisible = false
        }
    }
    
    func writeArticleToFirebase(){
        let article = Article(ean: ean, name: name, manufactorer: manufactorer, ingredients: ingredients, units: units, alternativProducts: alternitiveProducts, isForecasteArticle: isForecasteInventory, category: category)
        
        FirebaseRepository.shared.writeArticleToFirebase(FBArticle(article))
    }
    
    func getNumberFormatter(_ fragDigits: Int) -> NumberFormatter{
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = fragDigits
        return numberFormatter
    }
}
