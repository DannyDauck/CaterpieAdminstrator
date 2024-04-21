//
//  OrderView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 21.04.24.
//

import SwiftUI

struct OrderView: View {
    
    @StateObject var vm: ExcampleTableViewViewmodel
    
    var body: some View {
        VStack{
            HStack{
                Text(vm.inputString)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.white)
                Spacer()
            }.background(.gray.opacity(0.5))
            Spacer()
            Keypad(vm: vm)
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
    }
}

#Preview {
    OrderView(vm: ExcampleTableViewViewmodel())
}
