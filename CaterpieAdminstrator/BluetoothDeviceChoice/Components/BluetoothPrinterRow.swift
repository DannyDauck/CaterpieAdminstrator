//
//  BlueToothPrinterRowView.swift
//  Caterpie
//
//  Created by Danny Dauck on 03.03.24.
//

import SwiftUI
import CoreBluetooth

struct BlueToothPrinterRowView: View {
    
    @State var printer: BluetoothPrinter
    @State var isConnected: Bool = true
    var showAppend: Bool = true
    var cm = ColorManager.shared
    
    var body: some View {
        VStack{
            Text(printer.displayName)
                .fontWeight(isConnected ?  .bold : .regular)
            HStack{
                if isConnected {
                    ZStack{
                        Image(systemName: "dot.radiowaves.right")
                            .font(.title2)
                            .padding([.top, .leading], 2)
                        Image(systemName: "dot.radiowaves.right")
                            .font(.title2)
                            .foregroundStyle(cm.symbolActive)
                    }
                    
                }else{
                    Image(systemName: "dot.radiowaves.right")
                        .font(.title2)
                }
                Image(systemName: "printer.fill")
                    .font(.title2)
                ZStack{
                    Text("Drucker")
                        .padding([.top,.leading], 2)
                    Text("Drucker")
                        .foregroundStyle(cm.txtImportant)
                }
                
                
                
                
            }.padding(.horizontal)
                .padding(.vertical,4)
                .cornerRadius(15)
                .shadow(radius: 4)
            if isConnected{
                Button(action: {
                    BluetoothManager.shared.disconnectDevice(printer.peripheral)
                    isConnected = false
                }){
                    Text("trennen")
                }.buttonStyle(.borderedProminent)
                    .padding(.leading, 5)
               
            }else{
                Button(action:{
                    BluetoothManager.shared.connectDevice(printer.peripheral)
                    isConnected = true
                }){
                    Text("verbinden")
                }.buttonStyle(.borderedProminent)
                    .padding(.leading, 5)
            }
            if showAppend{
                ZStack{
                    HStack{
                        Image(systemName: "plus")
                            .font(.title3)
                            .padding([.top,.leading], 1)
                        Text("auswählen")
                            .font(.title3)
                            .padding([.top,.leading], 1)
                        
                    }
                    HStack{
                        Image(systemName: "plus")
                            .font(.title3)
                            .foregroundStyle(cm.txtImportant)
                        Text("auswählen")
                            .font(.title3)
                            .foregroundStyle(cm.txtImportant)
                    }
                }.onTapGesture {
                    BTPrinterViewModel.shared.printer = printer
                    BTPrinterViewModel.shared.sheetIsPresent = false
                }
            }
        }
    }
}



