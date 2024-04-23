//
//  NewArticleView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 25.03.24.
//

import SwiftUI

struct NewArticleView: View {
    
    @ObservedObject var vm: NewArticleViewViewmodel
    
    
    var body: some View {
        VStack{
            HStack{
                Text(vm.ean)
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                Spacer()
            }.background(.black)
            TextField("Name", text: $vm.name)
                .padding(.leading)
                .font(.title2)
                .fontWeight(.bold)
                .background(.gray.opacity(0.4))
            TextField("Hersteller", text: $vm.manufactorer)
                .padding(.leading)
                .background(.gray.opacity(0.2))
            ScrollView{
                HStack{
                    ZStack{
                        Text("Inhaltsstoffe")
                            .padding(.leading, 14)
                            .padding(.top, 4)
                            .foregroundStyle(.black)
                        Text("Inhaltsstoffe")
                            .padding(.leading)
                            .foregroundStyle(.white)
                    }
                    Spacer()
                }.background(LinearGradient(colors: [.gray.opacity(0.4), .black], startPoint: .leading, endPoint: .trailing))
                    .padding([.top, .bottom])
                ForEach($vm.ingredients, id: \.self){string in
                    HStack{
                        Text(string.wrappedValue)
                        Spacer()
                    }
                }
                HStack{
                    TextField("Zutat", text: $vm.currentIngredient)
                        .padding(.leading)
                    Button(action: {
                        if !vm.currentIngredient.isEmpty{
                            vm.ingredients.append(vm.currentIngredient)
                            vm.currentIngredient = ""
                        }
                    }){
                        Image(systemName: "plus.circle")
                            .font(.title2)
                            .padding(.trailing)
                    }
                }
                Divider()
                HStack{
                    ZStack{
                        Text("Einheiten")
                            .foregroundStyle(.black)
                            .padding(.leading, 14)
                            .padding(.top, 4)
                        Text("Einheiten")
                            .padding([.leading])
                            .foregroundStyle(.white)
                    }
                    Spacer()
                }
                .background(LinearGradient(colors: [.gray.opacity(0.4), .black], startPoint: .leading, endPoint: .trailing))
                    .padding([.top, .bottom])
                    
                if vm.unitWarningIsVisible{
                    ZStack{
                        Text("Erste Zieleinheit muss kalkulierbar sein, z.b. Gramm, Liter, Stück")
                            .padding([.top, .leading], 2)
                            .foregroundColor(.gray.opacity(0.5))
                        Text("Erste Zieleinheit muss kalkulierbar sein, z.b. Gramm, Liter, Stück")
                            .foregroundStyle(LinearGradient(colors: [.red, .orange,.red], startPoint: .bottomLeading, endPoint: .topTrailing))
                    }
                }
                
                ForEach($vm.units.indices, id: \.self){index in
                    HStack{
                        Text(vm.units[index].unit)
                        Text(" a ")
                        Text(String(vm.units[index].count) + " ")
                        Text(vm.units[index].targetIUnit + " ")
                        if  vm.units[index].deposit != nil{
                            Text("Pfand: " + String(vm.units[index].deposit!))
                        }
                        Spacer()
                        Button(action:{
                            vm.units.remove(at: index)
                        }){
                            Image(systemName: "trash")
                                .font(.title2)
                        }
                        
                        
                    }
                }
                Divider()
                HStack{
                    VStack{
                        HStack{
                            Text("Einheit")
                                .padding(.leading)
                            Picker("Unit", selection: $vm.currentUnit){
                                ForEach(Units.allCases, id: \.self){unit in
                                    Text(unit.tag())
                                }
                            }.padding(.leading)
                            Spacer()
                        }
                        HStack{
                            Text("Ziel")
                                .padding(.leading)
                            Picker("Unit", selection: $vm.targetUnit){
                                ForEach(Units.allCases, id: \.self){unit in
                                    Text(unit.tag())
                                }
                            }.padding(.leading)
                            TextField("1", value: $vm.currentUnitCount, formatter: vm.getNumberFormatter(3))
                                .keyboardType(.decimalPad)
                                .frame(width: 80)
                            Spacer()
                        }
                        HStack{
                            Text("Pfand")
                            TextField("1", value: $vm.currentDeposit, formatter: vm.getNumberFormatter(2))
                                .keyboardType(.decimalPad)
                        }.padding(.leading)
                    }
                    Button(action: {
                        if vm.currentUnitCount != 0.0{
                            vm.createUnitDependency()
                        }
                    }){
                        Image(systemName: "plus.circle")
                            .font(.title)
                    }.padding(.trailing)
                    Divider()
                    
                }
                .padding(.vertical)
                .background(.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal, 4)
                HStack{
                    Text("Bestelleinheit")
                        .padding(.leading)
                    Picker("OrderUnit", selection: $vm.orderUnit){
                        ForEach(Units.allCases, id: \.self){unit in
                            Text(unit.tag())
                        }
                    }.padding(.leading)
                    Spacer()
                }
                HStack{
                    ZStack{
                        Text("Sonstiges")
                            .padding(.leading, 14)
                            .padding(.top, 4)
                            .foregroundStyle(.black)
                        Text("Sonstiges")
                            .padding(.leading)
                            .foregroundStyle(.white)
                    }
                    Spacer()
                }.background(LinearGradient(colors: [.gray.opacity(0.4), .black], startPoint: .leading, endPoint: .trailing))
                    .padding([.top, .bottom])
                HStack{
                    Text("Artikel hat Schätzbestand")
                        .padding(.leading)
                    Button(action:{
                        vm.isForecasteInventory.toggle()
                    }){
                        ZStack{
                            Image(systemName: "square")
                                .font(.title2)
                            if vm.isForecasteInventory{
                                Image(systemName: "checkmark")
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    
                    Spacer()
                }
                Divider()
                HStack{
                    Text("Kategorie: ")
                        .padding(.leading)
                    TextField("Kategorie", text: $vm.category)
                    Spacer()
                }
                Spacer()
                
                Button(action: {
                    vm.writeArticleToFirebase()
                }){
                    Text("speichern")
                        .font(.title)
                        .padding(.vertical, 5)
                        .foregroundColor(.black)
                        .frame(width: 300)
                        .background(Capsule().foregroundColor(.white))
                        .padding(5)
                        .background(Capsule().foregroundStyle(LinearGradient(colors: [.yellow, .gray], startPoint: .bottomLeading, endPoint: .topTrailing)))
                }.padding(.top, 30)
            }
        }.navigationTitle("Artikel anlegen")
        
    }
}

#Preview {
    NewArticleView(vm: NewArticleViewViewmodel(ean: "4014558322961"))
}
