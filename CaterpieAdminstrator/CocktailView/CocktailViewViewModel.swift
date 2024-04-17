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
    let repo = ApiRepository()
    
    @MainActor
    func search(){
        Task{
            self.cocktail = await repo.getCocktail(searchText)
        }
    }
}
