//
//  MainScreenView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 25.03.24.
//

import SwiftUI


struct MainScreenView: View {
    
    @StateObject var vm: LoginViewViewmodel
    
    var body: some View {
        NavigationView {
            VStack{
                
                Spacer()
                
                NavigationLink(destination: ScannerView() ){
                    Text("Artikel scannen")
                        .font(.title)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                        .frame(width: 300)
                        .background(Capsule().foregroundColor(ColorManager.shared.primary))
                        .padding(5)
                        .background(Capsule().foregroundStyle(LinearGradient(colors: [.gray, .yellow], startPoint: .bottomLeading, endPoint: .topTrailing)))
                }
                NavigationLink(destination: ArticleOverview() ){
                    Text("Artikel Liste")
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
                        .background(Capsule().foregroundColor(ColorManager.shared.primary))
                        .padding(5)
                        .background(Capsule().foregroundStyle(LinearGradient(colors: [.gray, .yellow], startPoint: .bottomLeading, endPoint: .topTrailing)))
                }
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        vm.authorized = false
                    }){
                        ZStack{
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .padding([.top,.leading], 8)
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }.padding(6)
                            .background(Circle().foregroundStyle(ColorManager.shared.primary))
                            .padding(4)
                            .background(Circle().foregroundStyle(LinearGradient(colors: [.gray, .yellow], startPoint: .bottomLeading, endPoint: .topTrailing)))
                            .padding()
                    }
                        
                }
            }
            .navigationTitle("Willkommen \(FirebaseRepository.shared.userName)!")
            .background(
                ZStack{
                   /* Image(.zero)
                        .resizable()
                        .scaledToFill()
                    */
                    AsyncImage(url: URL(string: ColorManager.shared.backgroundURL), content: ({image in
                        image
                            .resizable()
                            .scaledToFill()
                    }), placeholder: {
                        Image(.zero)
                            .resizable()
                            .scaledToFill()
                    })
                    Color.white.opacity(0.4)
                }.background(.white.opacity(0.4))
            )
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
    MainScreenView(vm: LoginViewViewmodel())
}
