//
//  TableOverviewView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 21.04.24.
//

import SwiftUI

struct TableOverviewView: View {
    
    @StateObject var vm: ExcampleTableViewViewmodel
    
    var body: some View {
        VStack{
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
}

#Preview {
    TableOverviewView(vm: ExcampleTableViewViewmodel())
}
