//
//  SearchView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 21.04.24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var vm: ExcampleTableViewViewmodel
    
    var body: some View {
        ZStack{
            
            VStack{
                HStack(spacing: 0){
                    TextField("search", text: $vm.searchText)
                        .font(.title)
                        .textFieldStyle(.roundedBorder)
                    Button(action: {
                        vm.filterProducts()
                    }, label: {
                        Text("Suche")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }).buttonStyle(.borderedProminent)
                }
                ForEach(vm.currentProducts.indices, id: \.self) { rowIndex in
                    HStack() {
                        ForEach(vm.currentProducts[rowIndex], id: \.plu) { product in
                            ProductChip(product: product, vm: vm)
                        }
                    }
                }
                Spacer()
            }.background(
                ZStack{
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
                }
            )
            if vm.infoIsPresent{
                Color.white.opacity(0.4)
                ProductInfoView(vm: vm)
            }
        }
    }
}

#Preview {
    SearchView(vm: ExcampleTableViewViewmodel())
}
