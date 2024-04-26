//
//  RadioView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 24.04.24.
//

import SwiftUI

struct RadioView: View {
    
    //This file is for showcase how the app is interacting with the Caterpie main module. A click on a button will change the URL string in the firebase, while the AudioSettingsView from the main module has a listener on this file and starts a player when the URL changes.
    
    private var repo = FirebaseRepository.shared
    @State var animation = false
    @State var rainbowColorIndex = 0
    
    var body: some View {
        VStack{
            Spacer()
            Button(action: {
                repo.setRadioStream(RadioStations.bigFM.rawValue)
                animation = true
            }){
                Image(.bigFMSvg)
                    .resizable()
                    .frame(width: 60, height: 40)
                Text("BigFM 90er")
            }.padding([.leading, .trailing], 20)
                .foregroundColor(.black)
                .frame(width: 300)
                .background(Capsule().foregroundColor(.white))
                .padding(5)
                .background(Capsule().foregroundStyle(LinearGradient(colors: [.yellow, .gray], startPoint: .bottomLeading, endPoint: .topTrailing)))
            Button(action: {
                repo.setRadioStream(RadioStations.jumpFM.rawValue)
                animation = true
            }){
                Image(.jumpRadio)
                    .resizable()
                    .frame(width: 60, height: 40)
                Text("MDR Jump")
            }.padding([.leading, .trailing], 20)
                .foregroundColor(.black)
                .frame(width: 300)
                .background(Capsule().foregroundColor(.white))
                .padding(5)
                .background(Capsule().foregroundStyle(LinearGradient(colors: [.yellow, .gray], startPoint: .bottomLeading, endPoint: .topTrailing)))
            Button(action: {
                repo.setRadioStream(RadioStations.jahfariRadio.rawValue)
                animation = true
            }){
                Image(.jahfariRadio)
                    .resizable()
                    .padding(2)
                    .background(Circle().foregroundColor(.black))
                    .frame(width: 40, height: 40)
                Text("JahFari Radio")
            }.padding([.leading, .trailing], 20)
                .foregroundColor(.black)
                .frame(width: 300)
                .background(Capsule().foregroundColor(.white))
                .padding(5)
                .background(Capsule().foregroundStyle(LinearGradient(colors: [.yellow, .gray], startPoint: .bottomLeading, endPoint: .topTrailing)))
            Button(action: {
                repo.setRadioStream("n.a.")
                animation = false
            }){
                Text("stop radio")
                    .font(.title)
                    .fontWeight(.bold)
            }.padding([.leading, .trailing], 20)
                .foregroundColor(.white)
                .frame(width: 300)
                .background(Capsule().foregroundColor(ColorManager.shared.primary))
                .padding(5)
                .background(Capsule().foregroundStyle(LinearGradient(colors: [.yellow, .gray], startPoint: .bottomLeading, endPoint: .topTrailing)))
            
            Spacer()
        }.navigationTitle("Radio")
            .background(
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
                }.background(.white.opacity(0.4))
            )
        
    }
}

#Preview {
    RadioView()
}
