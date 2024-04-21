//
//  ProductChip.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 21.04.24.
//

import SwiftUI

struct ProductChip: View {
    
    @State var product: Product
    @StateObject var vm: ExcampleTableViewViewmodel
    
    var body: some View {
        VStack{
            Text(product.name)
            Text(product.price + "€")
        }.frame(width: 80, height: 80)
            .background(ColorManager.shared.menueSubItemBGInversed)
            .padding(3)
            .background(vm.categoryColors[product.category])
            .cornerRadius(8.0)
    }
}

#Preview {
    ProductChip(product: Product(name: "Cola 0.2l", plu: 204, articleDependencies: [], tags: [], price: "2.90", category: "Softdrinks"), vm: ExcampleTableViewViewmodel())
}
