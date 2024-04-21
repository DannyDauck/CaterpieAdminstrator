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
}
