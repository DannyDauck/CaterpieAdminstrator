//
//  ExcampleTableView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 21.04.24.
//

import SwiftUI

struct ExcampleTableView: View {
    
    @StateObject var vm = ExcampleTableViewViewmodel()
    @StateObject var btVm = BTPrinterViewModel.shared
    
    var body: some View {
        TabView(selection: $vm.selectedTab){
            SearchView(vm: vm)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                        .padding(.top)
                    Text("   Suche")
                        .padding(.top)
                }
                .tag(1)
            OrderView(vm: vm)
                .tabItem {
                    Image(systemName: "plus.viewfinder")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    Text("Bestellung")
                        .padding(.top)
                }
                .tag(2)
            TableOverviewView(vm: vm)
                .tabItem {
                    Image(systemName: "doc.text.image.fill")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                        .padding(.top)
                    Text("Tischübersicht")
                }
                .tag(3)
        }.onAppear{
            vm.loadProducts()
            if btVm.printer == nil{
                btVm.sheetIsPresent = true
            }
        }.sheet(isPresented: $btVm.sheetIsPresent){
            BTDeviceChoiceView()
        }.navigationTitle("Order")
    }
}

#Preview {
    ExcampleTableView()
}
