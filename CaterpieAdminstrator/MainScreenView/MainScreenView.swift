//
//  MainScreenView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 25.03.24.
//

import SwiftUI

struct MainScreenView: View {
    
    
    var body: some View {
        NavigationView {
            VStack{
                
                
                NavigationLink(destination: ScannerView() ){
                    Text("Artikel scannen")
                        .font(.title)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                        .frame(width: 300)
                        .background(Capsule().foregroundColor(.black))
                        .padding(5)
                        .background(Capsule().foregroundStyle(LinearGradient(colors: [.gray, .yellow], startPoint: .bottomLeading, endPoint: .topTrailing)))
                }
                NavigationLink(destination: ArticleOverview() ){
                    Text("Artikel bearbeiten")
                        .font(.title)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                        .frame(width: 300)
                        .background(Capsule().foregroundColor(.gray.opacity(0.2)))
                        .padding(5)
                        .background(Capsule().foregroundStyle(LinearGradient(colors: [.gray, .yellow], startPoint: .bottomLeading, endPoint: .topTrailing)))
                }
                Button(action:  {}) {
                    Text("Append product")
                        .font(.title)
                        .padding(.vertical, 5)
                        .foregroundColor(.black)
                        .frame(width: 300)
                        .background(Capsule().foregroundColor(.white))
                        .padding(5)
                        .background(Capsule().foregroundStyle(LinearGradient(colors: [.yellow, .gray], startPoint: .bottomLeading, endPoint: .topTrailing)))
                }
                
                NavigationLink(destination: CocktailView()){
                    Text("Cocktails finden")
                        .font(.title)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                        .frame(width: 300)
                        .background(Capsule().foregroundColor(.black))
                        .padding(5)
                        .background(Capsule().foregroundStyle(LinearGradient(colors: [.gray, .yellow], startPoint: .bottomLeading, endPoint: .topTrailing)))
                }
            }
            .navigationTitle("Main Screen")
            .onAppear{
                Task{
                    do{
                        try await FirebaseRepository.shared.login()
                    }catch{
                        print("connection to firebase failed")
                    }
                }
            }
        }
    }
}

#Preview {
    MainScreenView()
}