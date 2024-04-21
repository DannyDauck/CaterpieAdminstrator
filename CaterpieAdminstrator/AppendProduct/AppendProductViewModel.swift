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
    @Published var articles: [ArticleDependency] = []
    @Published var currentArticle: String = ""
    @Published var tags: [String] = []
    @Published var currentTag: String = ""
    @Published var price = ""
    @Published var category = ""
    @Published var fbArticles: [Article] = []
    private var repo = FirebaseRepository.shared
    
    
    func writeProductToFirebase(){
        guard let pluNumber = Int(plu) else{
            return
        }
        
        repo.writeProductToFirebase(
            Product(name: name, plu: pluNumber, articleDependencies: articles, tags: tags, price: price, category: category)
        )
        
        
    }
    
    
    func fetchArticles(){
        //weak self verhindert memory leaks, da sonst fetchArticles das ViewModel referenziert und das ViewModel wiederum das repo referenziert und immer so weiter ...
                repo.fetchArticles{[weak self] in
                    self?.fbArticles = $0
                    if let nameIn = self?.fbArticles.first?.name{
                        self?.currentArticle = nameIn
                    }
                
            }
    }
    
    func appendArticleDependency(){
        guard let ean = fbArticles.filter({
            $0.name == currentArticle
        }).first?.ean else{
            return
        }
        articles.append(ArticleDependency(unit: unit.tag(), count: String(count), ean: ean))
    }
    
    func getNameFromEAN(_ ean: String) -> String{
        guard let nameOut = fbArticles.filter({
            $0.ean == ean
        }).first?.name else {
            return ""
        }
        
        return nameOut
    }
    
    func getArticleNameByEAN(_ ean: String) -> String{
        guard let name = fbArticles.filter({
            $0.ean == ean
        }).first?.name else{
            return "n.a."
        }
        return name
    }
}
