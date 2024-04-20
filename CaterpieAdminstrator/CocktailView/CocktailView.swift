//
//  SwiftUIView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 14.04.24.
//

import SwiftUI

struct CocktailView: View {
    
    @StateObject var vm = CocktailViewViewModel.shared
    
    
    
    var body: some View {
        VStack{
            HStack{
                TextField("suche", text: $vm.searchText)
                    .textFieldStyle(.roundedBorder)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding()
                    
                Button(action: {
                    vm.search()
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                })
            }
            if vm.cocktail == nil {
                Text("nicht gefunden")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }else{
                Text(vm.cocktail!.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(width: 500)
                    .background(.gray.opacity(0.4))
                    
                ForEach(vm.cocktail!.ingredients, id: \.self){ingredient in
                    HStack{
                        Text(ingredient)
                        Spacer()
                    }
                }
                
                Text(vm.cocktail!.instructions)
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.top,40)
                HStack{
                    Spacer()
                    Button(action: {
                        vm.print()
                    }){
                        HStack{
                            Image(systemName: "printer.fill")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            Text("Rezept drucken")
                        }
                    }
                }.padding()
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $vm.sheetIsPresent){
            BTDeviceChoiceView()
        }
        .onAppear{
            print(vm.cocktail)
        }
    }
}

#Preview {
    CocktailView()
}
