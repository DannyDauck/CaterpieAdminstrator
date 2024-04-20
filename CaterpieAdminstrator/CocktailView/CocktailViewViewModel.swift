//
//  CocktailViewViewModel.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 14.04.24.
//

import Foundation

class CocktailViewViewModel: ObservableObject{
    
    @Published var searchText = ""
    @Published var cocktail: Cocktail? = nil
    @Published var printer: BluetoothPrinter? = nil
    @Published var sheetIsPresent = false
    static var shared = CocktailViewViewModel()
    
    
    let repo = ApiRepository()
    
    @MainActor
    func search(){
        Task{
            self.cocktail = await repo.getCocktail(searchText)
        }
    }
    
    func print(){
        if printer == nil {
            sheetIsPresent = true
        }else{
            printer!.largeText("\(cocktail!.name)\n", .center, .bold)
            printer!.largeText("\n")
            cocktail?.ingredients.forEach{ingredient in
                printer?.text("\(ingredient)\n", .left, .normal)
            }
            printer?.largeText("\n")
            printer?.text("\(cocktail!.instructions)", .left, .bold)
            printer?.largeText("\n\n\n")
            printer?.largeText("\n")
        }
    }
}
