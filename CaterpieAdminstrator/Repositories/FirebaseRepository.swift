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
    var userName = ""
    var authorized = false
    
    private init(){}
    
    func login() async throws{
        
        do{
            try await auth.signIn(withEmail: Secrets.email.getValue(), password: Secrets.password.getValue())
        }catch{
            do{
                try await auth.createUser(withEmail: Secrets.email.getValue(), password: Secrets.password.getValue())
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
    
    func writeProductToFirebase(_ product: Product){
        do{
            try store.collection("exampleProducts").document(product.name).setData(from: product)
        }catch{
            print("Could not write product to data base")
        }
    }
    
    func writeTableToFirebase(_ table: Table){
        do{
            try store.collection("exampleTables").document(table.number).setData(from: table)
        }catch{
            print("Could not write article to data base")
        }
    }
    
    func deleteTable(_ table: Table){
        let ref = store.collection("exampleTables").document(table.number)
        ref.delete(){error in
            if let error{
                print("could not delete table")
            }
        }
    }
    
    
    func setRadioStream(_ stream: String){
        do{
            try store.collection("excampleAudio").document("audioURL").setData(["URL" : stream])
        }catch{
            print("could not set stream")
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
    
    func fetchProducts(completion: @escaping ([Product]) -> Void) {
        var products: [Product] = []
        
        store.collection("exampleProducts").getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error)")
                completion([])
                return
            }
            
            for document in documents {
                do {
                    let product = try document.data(as: Product.self)
                    products.append(product)
                } catch {
                    print("Error decoding article: \(error)")
                }
            }
            completion(products)
        }
    }
    
    func fetchTables(completion: @escaping ([Table]) -> Void) {
        var tables: [Table] = []
        
        store.collection("exampleTables").getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error)")
                completion([])
                return
            }
            
            for document in documents {
                do {
                    let table = try document.data(as: Table.self)
                    tables.append(table)
                } catch {
                    print("Error decoding article: \(error)")
                }
            }
            completion(tables)
        }
    }
}
