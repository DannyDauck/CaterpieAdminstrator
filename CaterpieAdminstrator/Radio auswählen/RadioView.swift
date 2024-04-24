//
//  RadioView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 24.04.24.
//

import SwiftUI

struct RadioView: View {
    
    private var repo = FirebaseRepository.shared
    
    var body: some View {
        VStack{
            Spacer()
            Button(action: {
                repo.setRadioStream(RadioStations.bigFM.rawValue)
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
                repo.setRadioStream("n.a.")
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
                   /* Image(.zero)
                        .resizable()
                        .scaledToFill()
                    */
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
