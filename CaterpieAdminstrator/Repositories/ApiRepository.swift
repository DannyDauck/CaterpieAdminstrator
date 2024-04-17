//
//  ApiRepository.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 14.04.24.
//
let API_KEY = "w3GwUVGOlzkdgNBQItTl5Q==wYWcZBV2swzfXpCt"

import Foundation


class ApiRepository{
    
   
    func getCocktail(_ searchText: String) async -> Cocktail?{
        let name = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/cocktail?name="+name!)!
        var request = URLRequest(url: url)
        request.setValue(API_KEY, forHTTPHeaderField: "X-Api-Key")
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData =  try JSONDecoder().decode([Cocktail].self, from: data)
            return decodedData.first
            
        }catch{
            return nil
        }
    }
    
    
}




