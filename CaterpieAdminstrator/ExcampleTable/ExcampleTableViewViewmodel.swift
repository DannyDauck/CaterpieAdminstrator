//
//  ExcampleTableViewViewmodel.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 21.04.24.
//

import Foundation
import AVKit
import SwiftUI


class ExcampleTableViewViewmodel: ObservableObject{
    
    private var allProducts: [Product] = []
    @Published var products: [Product] = []
    @Published var currentProducts: [[Product]] = []
    @Published var selectedTab = 2
    private var repo = FirebaseRepository.shared
    var categoryColors: [String: Color] = [:]
    
    @Published var searchText = ""
    @Published var inputString = ""
    
    
    func loadProducts(){
        repo.fetchProducts{[weak self] products in
            self?.products = products.sorted{ (product1, product2) -> Bool in
                //sortiert erst nach Kategorie und dann innerhalb der Kategorie nach Namen
                if product1.category == product2.category {
                    return product1.name < product2.name
                } else {
                    return product1.category < product2.category
                }
            }
            //Ich brauch die Produkte zweimal damit ich sie einmal filtern kann und daraus wieder die Tabelle kalkulieren kann
            self?.allProducts = products.sorted{ (product1, product2) -> Bool in
                if product1.category == product2.category {
                    return product1.name < product2.name
                } else {
                    return product1.category < product2.category
                }
            }
            self?.updateCategoryColors()
            self?.calculateProductTable(4)
        }
    }
    
    private func updateCategoryColors() {
        var uniqueCategories: Set<String> = Set()
        
        for product in products {
            uniqueCategories.insert(product.category)
        }
        let availableColors: [Color] = [.red, .blue, .green, .orange, .yellow, .purple, .indigo, .cyan, .brown,  .pink]
        for (index, category) in uniqueCategories.enumerated() {
            let colorIndex = index % availableColors.count
            categoryColors[category] = availableColors[colorIndex]
        }
    }
    
    private func calculateProductTable(_ rowCount: Int = 5){
        var newRow: [Product] = []
        for (index, product) in products.enumerated(){
            newRow.append(product)
            if (index + 1)%rowCount == 0 {
                currentProducts.append(newRow)
                newRow = []
            }
        }
        //Letzt Reihe hinzufügen wenn nicht leer
        if !newRow.isEmpty {
            currentProducts.append(newRow)
        }
    }
    
    func filterProducts(){
        products = allProducts.filter{product in
            product.name.contains(searchText)||product.category.contains(searchText)||product.tags.filter{tag in
                tag.contains(searchText)
            }.isEmpty == false
        }
        currentProducts = []
        calculateProductTable()
    }
    
}
