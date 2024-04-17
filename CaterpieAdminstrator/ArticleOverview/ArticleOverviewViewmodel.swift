//
//  ArticleOverviewViewmodel.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 26.03.24.
//

import Foundation


class ArticleOverviewViewmodel: ObservableObject{
    
    let repo = FirebaseRepository.shared
    
    var articles: [Article] = []
    
    
    func fetchArticles(){
        Task{
            repo.fetchArticles{
                self.articles = $0
            }
        }
    }
}
