//
//  TableOverviewView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 21.04.24.
//

import SwiftUI
import CoreMotion

struct TableOverviewView: View {
    
    @ObservedObject var vm: ExcampleTableViewViewmodel
    
    let motionManager = CMMotionManager()
    @State private var isUpsideDown = false
    
    
    var body: some View {
        VStack{
            ZStack{
                if vm.currentTable == nil{
                    ForEach(vm.tables, id: \.number){table in
                        HStack{
                            HStack{
                                Text(table.number)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .padding(.leading)
                                Spacer()
                                Text(numberFormat(table.sum))
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .padding(.trailing)
                            }.background(.gray.opacity(0.9))
                                .cornerRadius(8.0)
                        }.onTapGesture {
                            vm.currentTable = table
                        }
                    }
                }else{
                    VStack{
                        Text(vm.currentTable!.number)
                        ForEach(vm.currentTable!.orders, id: \.name){order in
                            HStack{
                                Text(String(order.count))
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .padding(.leading)
                                Text(order.name)
                                Spacer()
                                Text(numberFormat(order.price))
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .padding(.trailing)
                            }
                        }
                        Divider()
                            .foregroundStyle(.black)
                        HStack{
                            Text("Summe")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .padding(.leading)
                            Spacer()
                            ZStack{
                                Text(numberFormat(vm.currentTable!.sum))
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .padding(.trailing)
                                    .padding([.top, .leading], 3)
                                    .foregroundStyle(.gray)
                                Text(numberFormat(vm.currentTable!.sum))
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .padding(.trailing)
                                    .foregroundStyle(ColorManager.shared.txtImportant)
                            }
                        }
                        Spacer()
                        Button(action:{
                            vm.currentTable = nil
                        }){
                            Text("zurück")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(ColorManager.shared.primary.opacity(0.8))
                                .padding(3)
                                .background(ColorManager.shared.btnBgActive)
                        }
                        Button(action:{
                            vm.pay()
                        }){
                            Text("bezahlen")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(ColorManager.shared.primary)
                                .padding(3)
                                .background(ColorManager.shared.btnBgActive)
                        }
                    }.background(.gray.opacity(0.9))
                        .rotationEffect(.degrees(isUpsideDown ? 180 : 0))
                        .onAppear{
                            //Dreht die Rechnung damit sie der Kunde lesen kann, wenn das Handy aus dem Handgelenk kopfüber gekippt wird
                            startDeviceOrientationMonitoring()
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
    }
    
    func startDeviceOrientationMonitoring() {
            guard motionManager.isDeviceMotionAvailable else {
                print("Device motion is not available.")
                return
            }
            
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { motion, error in
                guard let motion = motion else {
                    print("Failed to get device motion: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                // Überprüfe, ob das Gerät kopfüber ist
                let isUpsideDown = motion.gravity.z < -0.8 // Z-Komponente der Schwerkraft
                self.isUpsideDown = isUpsideDown
            }
        }
}

#Preview {
    TableOverviewView(vm: ExcampleTableViewViewmodel())
}
