//
//  ArticleOverview.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 26.03.24.
//

import SwiftUI

struct ArticleOverview: View {
    
    @ObservedObject var vm = ArticleOverviewViewmodel()
    
    init(){
        vm.fetchArticles()
    }
    
    var body: some View {
        if vm.articles.isEmpty{
            Text("Noch keine Artikel vorhanden")
        }
        List($vm.articles, id: \.self.ean){article in
            Text(article.wrappedValue.name)
        }
        
    }
}

#Preview {
    ArticleOverview()
}
