//
//  BTPrinterViewModel.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 20.04.24.
//

import Foundation


class BTPrinterViewModel: ObservableObject{
    
    
    @Published var printer: BluetoothPrinter? = nil
    @Published var sheetIsPresent = false
    static var shared = BTPrinterViewModel()
    
    private init(){
        
    }
    
    func printCocktail(_ cocktail: Cocktail){
        if printer == nil {
            sheetIsPresent = true
        }else{
            printer!.largeText("\(cocktail.name)\n", .center, .bold)
            printer!.largeText("\n")
            cocktail.ingredients.forEach{ingredient in
                printer?.text("\(ingredient)\n", .left, .normal)
            }
            printer?.largeText("\n")
            printer?.text("\(cocktail.instructions)", .left, .bold)
            printer?.largeText("\n\n\n")
            printer?.largeText("\n")
        }
    }
    
    func printBill(_ table: Table){
        guard let pt = printer else{
            sheetIsPresent = true
            return
        }
        pt.largeText("\n\nCaterpie Cafe\n\n", .center, .bold)
        pt.text("Schneebergstr. 33, 01277 Dresden", .center)
        pt.largeText("\n\n\n")
        pt.text(table.number, .left, .bold)
        pt.text("\n", .left)
        for order in table.orders{
            pt.text(makeSameSizedString("\(order.count) \(order.name)", "\(numberFormat(order.price).replacingOccurrences(of: "€", with: ""))"), .left)
        }
        pt.text("\n")
        pt.text(makeSameSizedString("Summe", "\(numberFormat(table.sum).replacingOccurrences(of: "€", with: ""))"), .left, .bold)
        pt.text("\n\n\n\(Date.now)\nEs bediente sie \(FirebaseRepository.shared.userName)\n\n")
        pt.text("\n")
        
    }
    
    private func makeSameSizedString(_ first: String, _ sec: String, _ length: Int = 40) -> String{
        
        var newFirst = first.replacingOccurrences(of: "ö", with: "oe")
        newFirst = newFirst.replacingOccurrences(of: "ä", with: "ae")
        newFirst = newFirst.replacingOccurrences(of: "ü", with: "ue")
        let spaceCount = length - newFirst.count - sec.count
        var newString = newFirst
        for _ in 0..<spaceCount {
            newString.append(" ")
        }
        var newSec = sec
        newSec.removeLast()
        newString.append(newSec)
        newString.append("\n")
        return newString
    }
    
    func printOrder(_ table: String, _ orders: [Order]){
        
        guard let pt = printer else {
            sheetIsPresent = true
            return
        }
        
        
        pt.largeText(table, .left, .bold)
        pt.text("\n\n")
        for order in orders{
            pt.largeText("\(order.count) \(order.name)\n", .left, .normal)
        }
        pt.text("\n\n\n")
        pt.text("\n")
    }
}
