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
    @Published var articles: [Article] = []
    @Published var currentProducts: [[Product]] = []
    @Published var selectedTab = 2
    private var repo = FirebaseRepository.shared
    var categoryColors: [String: Color] = [:]
    
    @Published var searchText = ""
    @Published var inputString = ""
    @Published var currentProduct: Product? = nil
    @Published var infoIsPresent = false
    
    @Published var tables: [Table] = []
    @Published var currentTable: Table? = nil
    @Published var currentOrder: [Order] = []
    @Published var lastOrder: Order? = nil
    @Published var headerColor = Color.white
    @Published var invalidInput = false
    @Published var invalidInputString = "ungültige Eingabe"
    
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
        
        repo.fetchArticles{[weak self] articles in
            self?.articles = articles
        }
        repo.fetchTables{[weak self] tables in
            self?.tables = tables
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
    
    func setTable(){
        if inputString.isEmpty{
            currentTable = nil
            return
        }
        if inputString.contains("*"){
            invalidInputString = "Ungültige Eingabe"
            invalidInput = true
        }else{
            if tables.contains(where: {table in
                table.number == "Tisch \(inputString)"
            }){
                currentTable = tables.filter({table in
                    table.number == "Tisch \(inputString)"
                }).first
                inputString = ""
            }else{
                var newTable = Table(number: "Tisch \(inputString)", orders: [])
                currentTable = newTable
                tables.append(newTable)
                inputString = ""
            }
        }
    }
    
    func getOrder(){
        if inputString.contains("*"){
            let parts = inputString.split(separator: "*")
            guard let product = products.first(where: {
                $0.plu == Int(parts[1])
            }) else {
                invalidInputString = "PLU nicht gefunden"
                invalidInput = true
                return
            }
            if parts[1].contains("."){
                invalidInputString = "ungültige Eingabe"
                invalidInput = true
                return
            }
            
            guard let price = Float(product.price) else {
                return
            }
            guard let count = Int(parts[0]) else {
                return
            }
            
            let newOrder = Order(count: count, name: product.name, price: String(Float(count) * price))
            appendNewOrder(newOrder)
            lastOrder = newOrder
            inputString = ""
            invalidInput = false
        }else{
            if inputString.contains("."){
                invalidInputString = "ungültige Eingabe"
                invalidInput = true
                return
            }
            guard let product = products.first(where: {
                $0.plu == Int(inputString)
            }) else {
                invalidInputString = "PLU nicht gefunden"
                invalidInput = true
                return
            }
            let newOrder = Order(count: 1, name: product.name, price: product.price)
            appendNewOrder(newOrder)
            lastOrder = newOrder
            invalidInput = false
            inputString = ""
        }
    }
    
    private func appendNewOrder(_ order: Order){
        
        if currentOrder.contains(where: {
            $0.name == order.name
        }){
            var oldOrder = currentOrder.first(where: {
                $0.name == order.name
            })
            print(oldOrder)
            guard let oldPrice = Float(oldOrder!.price) else {
                print("could not create float from price")
                return
            }
            
            
            let newPrice = oldPrice + Float(order.price)!
            let newCount = oldOrder!.count + order.count
            print(newPrice)
            print(newCount)
            
            currentOrder.append(Order(count: newCount, name: oldOrder!.name, price: String(newPrice)))
            currentOrder.removeAll(where: {
                $0.name == oldOrder?.name && $0.count == oldOrder?.count
            })
            
            
            inputString = ""
            
        }else{
            currentOrder.append(order)
            inputString = ""
        }
    }
    func instantCancellation(){
        var newOrder = currentOrder.first(where: {
            $0.name == lastOrder!.name
        })
        //Ich kann ohne Probleme unwrappen da newOrder existieren muss
        newOrder!.count = newOrder!.count - lastOrder!.count
        
        currentOrder.removeAll(where: {
            $0.name == newOrder?.name
        })
        currentOrder.append(newOrder!)
        lastOrder = nil
    }
    
    func matchOrder(){
        if BTPrinterViewModel.shared.printer == nil{
            BTPrinterViewModel.shared.sheetIsPresent = true
        }else if !currentOrder.isEmpty && currentTable != nil{
            for order in currentOrder{
                if currentTable!.orders.contains(where: {
                    $0.name == order.name
                }){
                    var newOrder = currentTable!.orders.first(where: {
                        $0.name == order.name
                    })!
                    newOrder.count = order.count + newOrder.count
                    newOrder.price = String(Float(newOrder.price)! + Float(order.price)!)
                    currentTable?.orders.removeAll(where: {$0.name == newOrder.name})
                    currentTable?.orders.append(newOrder)
                }else{
                    currentTable!.orders.append(order)
                }
            }
            tables.removeAll(where: {
                $0.number == currentTable?.number
            })
            tables.append(currentTable!)
            repo.writeTableToFirebase(currentTable!)
            BTPrinterViewModel.shared.printOrder(currentTable!.number, currentOrder)
            currentOrder = []
            currentTable = nil
            lastOrder = nil
            inputString = ""
        }
    }
    
    func pay(){
        repo.deleteTable(currentTable!)
        tables.removeAll(where: {
            $0.number == currentTable?.number
        })
        BTPrinterViewModel.shared.printBill(currentTable!)
        currentTable = nil
    }
}
