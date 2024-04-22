//
//  ProductInfoView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 22.04.24.
//

import SwiftUI

struct ProductInfoView: View {
    
    @State var vm: ExcampleTableViewViewmodel
    
    var body: some View {
        VStack{
            ScrollView{
                HStack{
                    ZStack{
                        Text(vm.currentProduct?.name ?? "n.a.")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.gray)
                            .padding([.top, .leading], 3)
                        Text(vm.currentProduct?.name ?? "n.a.")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.white)
                    }.padding(5)
                    Spacer()
                    ZStack{
                        Image(systemName: "xmark.circle")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundStyle(.gray)
                            .padding([.top, .leading], 3)
                        Image(systemName: "xmark.circle")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }.onTapGesture {
                        vm.infoIsPresent = false
                    }.padding(.trailing)
                }.frame(width: 300)
                    .background(.black.opacity(0.7))
                HStack{
                    Text("PLU: ")
                        .frame(width: 100)
                    Text(String(vm.currentProduct?.plu ?? 000))
                    Spacer()
                    
                }
                HStack{
                    Text("Preis: ")
                        .frame(width: 100)
                    Text(String(vm.currentProduct?.price ?? "n.a."))
                    Spacer()
                }
                HStack{
                    Text("Kategorie: ")
                        .frame(width: 100)
                    Text(String(vm.currentProduct?.category ?? "n.a."))
                    Spacer()
                }
                HStack{
                    Text("Zutaten")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.white)
                        .padding(.leading)
                    Spacer()
                }.background(.black.opacity(0.8))
                ForEach(vm.currentProduct?.articleDependencies ?? [], id: \.ean){dependency in
                    HStack{
                        Text(dependency.count)
                        Text(dependency.unit)
                        Text(vm.articles.first(where: {
                            $0.ean == dependency.ean
                        })?.name ?? "n.a")
                        Spacer()
                    }
                }
                HStack{
                    Text("Tags")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.white)
                        .padding(.leading)
                    Spacer()
                }.background(.black.opacity(0.8))
                ForEach(vm.currentProduct?.tags ?? ["n.a."], id: \.self){tag in
                    HStack{
                        Text(tag)
                        Spacer()
                    }.padding(.leading)
                }
                HStack{
                    Text("Inhaltsstoffe")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.white)
                        .padding(.leading)
                    Spacer()
                }.background(.black.opacity(0.8))
                HStack{
                    Text(vm.getIngredientsFromProduct())
                    Spacer()
                }
                
            }.background(.gray.opacity(0.8))
                .frame(width: 300)
                .cornerRadius(10.0)
            
        }
    }
}

#Preview {
    ProductInfoView(vm: ExcampleTableViewViewmodel())
}
