//
//  AppendProductView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 20.04.24.
//

import SwiftUI

struct AppendProductView: View {
    
    @StateObject var vm = AppendProductViewModel()
    
    var body: some View {
        VStack{
            HStack{
                Text("Neues Produkt")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.leading)
                Spacer()
            }.background(.gray.opacity(0.4))
            HStack{
                Text("Name: ")
                    .frame(width: 100)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .font(.title2)
                TextField("name", text: $vm.name)
                    .font(.title2)
                    .padding(.leading)
                    .background(.gray.opacity(0.8))
                    .padding(.trailing)
            }
            HStack{
                Text("PLU: ")
                    .frame(width: 100)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .font(.title2)
                TextField("plu", text: $vm.plu)
                    .font(.title2)
                    .padding(.leading)
                    .background(.gray.opacity(0.8))
                    .padding(.trailing)
                    .keyboardType(.numberPad)
            }
            HStack{
                Text("Zutaten")
                    .frame(width: 100)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
               
            }.background(.gray.opacity(0.4))
                .padding(.top)
            HStack{
                TextField("0.0", value: $vm.count, formatter: NumberFormatter())
                    .padding(.leading)
                    .background(.gray.opacity(0.8))
                    .frame(width: 60)
                Picker("OrderUnit", selection: $vm.unit){
                    ForEach(Units.allCases, id: \.self){unit in
                        Text(unit.tag())
                    }
                }.padding(.leading)
                Picker("Article", selection: $vm.currentArticle){
                    ForEach(vm.fbArticles, id: \.self.ean){article in
                        Text(article.name)
                    }
                }
                
            }
            HStack{
                Button(action: {
                    
                }){
                    Text("hinzufügen")
                }.buttonStyle(.borderedProminent)
                    .padding()
                Spacer()
            }
            Divider()
                .foregroundColor(.gray)
            Spacer()
        }.onAppear{
            //Wieder einkommentiereten wenn UI fertig
           // vm.fetchArticles()
        }
    }
}

#Preview {
    AppendProductView()
}
