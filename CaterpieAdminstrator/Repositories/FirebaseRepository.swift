//
//  FirebaseRepository.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 26.03.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebaseRepository{
    
    static let shared = FirebaseRepository()
    var auth = FirebaseAuth.Auth.auth()
    var store = Firestore.firestore()
    
    private init(){}
    
    func login() async throws{
        
        do{
            try await auth.signIn(withEmail: "danny.dauck@CaterpieAdmin.com", password: "kjodsj4567@jshaüßJKLO")
        }catch{
            do{
                try await auth.createUser(withEmail: "danny.dauck@CaterpieAdmin.com", password: "kjodsj4567@jshaüßJKLO")
            }catch{
                print("could not sign in or up")
            }
        }
    }
    
    func writeArticleToFirebase(_ article: FBArticle){
        do{
            try store.collection("exampleArticle").document(article.ean).setData(from: article)
        }catch{
            print("Could not write article to data base")
        }
    }
    
    func fetchArticles(completion: @escaping ([Article]) -> Void) {
        var articles: [Article] = []
        
        store.collection("exampleArticle").getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error)")
                completion([])
                return
            }
            
            for document in documents {
                do {
                    let article = try document.data(as: FBArticle.self)
                    articles.append(Article(article))
                } catch {
                    print("Error decoding article: \(error)")
                }
            }
            
            completion(articles)
        }
    }
}
