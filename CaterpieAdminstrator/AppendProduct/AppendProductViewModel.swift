//
//  AppendProductViewModel.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 20.04.24.
//

import Foundation


class AppendProductViewModel: ObservableObject{
    
    @Published var name: String = ""
    @Published var plu: String = ""
    @Published var article: Article? = nil
    @Published var count: Float = 0.0
    @Published var unit: Units = .centiliter
    @Published var tags: [String] = []
    @Published var currentTag: String = ""
    
    
}
