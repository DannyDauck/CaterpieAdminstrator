//
//  Keypad.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 21.04.24.
//

import SwiftUI

struct Keypad: View {
    
    @StateObject var vm: ExcampleTableViewViewmodel
    @State var cm = ColorManager.shared
    @State var am = AudioManager()
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                Button(action: {
                    //Storn implementieren
                    if vm.stornoIsActive{
                        //Stornomethode
                        vm.storno()
                    }else{
                        if vm.currentTable != nil{
                            vm.stornoIsActive = true
                        }
                    }
                }){
                    Text("Storno")
                        .frame(width: 80, height: 60)
                        .background(vm.stornoIsActive ? ColorManager.shared.exceptionGradient : LinearGradient(colors: [.red.opacity(0.9)], startPoint: .leading, endPoint: .trailing))
                        .foregroundStyle(vm.stornoIsActive ? .green : .black)
                        .padding(vm.stornoIsActive ? 2 : 0)
                        .background(.green)
                        
                }
                Button(action: {
                    //Storn implementieren
                    vm.instantCancellation()
                    am.play(.trash)
                }){
                    Text("Sofort\nStorno")
                        .frame(width: 80, height: 60)
                        .background(.red.opacity(0.6))
                        .foregroundStyle(.black)
                        .background(.white)
                        
                }
                Button(action: {
                    //Storn implementieren
                }){
                    Text("Split")
                        .frame(width: 80, height: 60)
                        .background(cm.primary.opacity(0.6))
                        .foregroundStyle(.black)
                        .background(.white)
                        
                }
                Button(action: {
                    vm.inputString = String(vm.inputString.dropLast())
                    am.play(.click)
                }){
                    ZStack{
                        Image(systemName: "chevron.left.2")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(cm.txtImportant)
                            .padding([.top, .leading], 3)
                        Image(systemName: "chevron.left.2")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.white)
                    }
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(.blue.opacity(0.6))
                        .foregroundStyle(.black)
                        
                }
            }
            HStack(spacing: 0){
                VStack(spacing: 0){
                    HStack(spacing: 0){
                        Button(action: {
                            vm.inputString.append("1")
                            am.play(.click)
                        }){
                            Text("1")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                        }.frame(width: 80, height: 40)
                            .background(cm.btnBgInactive)
                        Button(action: {
                            vm.inputString.append("2")
                            am.play(.click)
                        }){
                            Text("2")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                        }.frame(width: 80, height: 40)
                            .background(cm.btnBgInactive)
                        
                        Button(action: {
                            vm.inputString.append("3")
                            am.play(.click)
                        }){
                            Text("3")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                        }.frame(width: 80, height: 40)
                            .background(cm.btnBgInactive)
                        
                    }
                    HStack(spacing: 0){
                        Button(action: {
                            vm.inputString.append("4")
                            am.play(.click)
                        }){
                            Text("4")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                        }.frame(width: 80, height: 40)
                            .background(cm.btnBgInactive)
                        Button(action: {
                            vm.inputString.append("5")
                            am.play(.click)
                        }){
                            Text("5")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                        }.frame(width: 80, height: 40)
                            .background(cm.btnBgInactive)
                        
                        Button(action: {
                            vm.inputString.append("6")
                            am.play(.click)
                        }){
                            Text("6")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                        }.frame(width: 80, height: 40)
                            .background(cm.btnBgInactive)
                        
                    }
                    HStack(spacing: 0){
                        Button(action: {
                            vm.inputString.append("7")
                            am.play(.click)
                        }){
                            Text("7")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                        }.frame(width: 80, height: 40)
                            .background(cm.btnBgInactive)
                        Button(action: {
                            vm.inputString.append("8")
                            am.play(.click)
                        }){
                            Text("8")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                        }.frame(width: 80, height: 40)
                            .background(cm.btnBgInactive)
                        
                        Button(action: {
                            vm.inputString.append("9")
                            am.play(.click)
                        }){
                            Text("9")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                        }.frame(width: 80, height: 40)
                            .background(cm.btnBgInactive)
                        
                    }
                    HStack(spacing: 0){
                        Button(action: {
                            if !vm.inputString.contains("."){
                                vm.inputString.append(".")
                            }
                            am.play(.click)
                        }){
                            Text(".")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                        }.frame(width: 80, height: 40)
                            .background(cm.btnBgInactive)
                        Button(action: {
                            vm.inputString.append("0")
                            am.play(.click)
                        }){
                            Text("0")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                        }.frame(width: 80, height: 40)
                            .background(cm.btnBgInactive)
                        
                        Button(action: {
                            if vm.currentTable != nil{
                                vm.inputString.append("*")
                            }
                            am.play(.click)
                        }){
                            Text("*")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                        }.frame(width: 80, height: 40)
                            .background(cm.btnBgInactive)
                        
                    }
                }
                VStack(spacing: 0){
                    Button(action: {
                        //Tischbutton
                        if vm.currentTable == nil{
                            vm.setTable()
                        }else{
                            if !vm.stornoIsActive{
                                if !vm.currentOrder.isEmpty{
                                    vm.matchOrder()
                                }
                                vm.setTable()
                            }else{
                                vm.storno()
                            }
                        }
                    }){
                        Text("Tisch")
                            .frame(height: 78)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.white)
                            .background(cm.btnBgInactive)
                            .padding(2)
                            .background(cm.primary)
                    }
                    Button(action: {
                        //OK-Button
                        if !vm.stornoIsActive{
                            if vm.currentTable == nil{
                                vm.setTable()
                            }else{
                                vm.getOrder()
                            }
                        }
                    }){
                        Text("OK")
                            .frame(height: 78)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(cm.txtImportant)
                            .background(cm.primary)
                            .padding(2)
                            .background(cm.btnBgInactive)
                    }
                }
            }
        }.frame(height: 240)
    }
}

#Preview {
    Keypad(vm: ExcampleTableViewViewmodel())
}
