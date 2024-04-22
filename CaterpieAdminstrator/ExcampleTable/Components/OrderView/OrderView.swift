//
//  OrderView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 21.04.24.
//

import SwiftUI

struct OrderView: View {
    
    @StateObject var vm: ExcampleTableViewViewmodel
    @StateObject var btVm = BTPrinterViewModel.shared
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                if vm.currentTable == nil{
                    ZStack{
                        Text("Kein Tisch ausgewählt")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundStyle(.gray)
                            .padding([.top, .leading], 3)
                        Text("Kein Tisch ausgewählt")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundStyle(vm.headerColor)
                    }
                }else{
                    ZStack{
                        Text("\(vm.currentTable!.number)")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.gray)
                            .padding([.top, .leading], 3)
                        Text("\(vm.currentTable!.number)")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(vm.headerColor)
                    }
                }
                Spacer()
            }.padding(.bottom, 5)
                .background(.black.opacity(0.7))
            if vm.invalidInput{
                ZStack{
                    Text(vm.invalidInputString)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                        .padding([.top, .leading], 3)
                    Text(vm.invalidInputString)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                        .foregroundStyle(ColorManager.shared.exceptionGradient)
                }
            }
            HStack{
                Text(vm.inputString)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.white)
                    .padding(.leading)
                Spacer()
            }.background(.gray.opacity(0.5))
            HStack{
                VStack{
                    HStack{
                        Spacer()
                        Text("AktuellerTisch")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        
                        Spacer()
                    }
                    ScrollView{
                        ForEach(vm.currentTable?.orders ?? [], id: \.name){order in
                            OrderRow(order: order)
                                .onLongPressGesture{
                                    if vm.stornoIsActive{
                                        vm.stornoArray.append(order)
                                    }
                                }
                        }
                    }.frame(maxHeight: .infinity)
                }
                VStack{
                    HStack{
                        Spacer()
                        Text(vm.stornoIsActive ? "Stornomodus" : "Aktuelle Bestellung")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    if !vm.stornoIsActive{
                        if vm.lastOrder != nil{
                            OrderRow(order: vm.lastOrder!, isLastOrder: true)
                        }
                        ScrollView{
                            ForEach(vm.currentOrder, id: \.name){
                                OrderRow(order: $0)
                            }
                        }.frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }else{
                        ScrollView{
                            ForEach(vm.stornoArray, id: \.name){
                                OrderRow(order: $0)
                            }
                        }.frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                }
            }
            Spacer()
            Keypad(vm: vm)
                .padding(0)
                .padding(.bottom, 5)
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
