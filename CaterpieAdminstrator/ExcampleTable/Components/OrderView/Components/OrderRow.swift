//
//  OrderRow.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 22.04.24.
//

import SwiftUI

struct OrderRow: View {
    
    @State var order: Order
    @State var isLastOrder = false
    
    var body: some View {
        VStack{
            HStack{
                Text(String(order.count))
                    .font(.title2)
                    .padding([.trailing, .leading])
                Text(order.name)
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                
            }
            
            HStack{
                Spacer()
                Text(numberFormat(order.price))
                    .padding(.trailing)
            }
        }.background(isLastOrder ? ColorManager.shared.primary.opacity(0.9) : Color.gray.opacity(0.9))
    }
}

func numberFormat(_ string: String) -> String{
    if let price = Float(string) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        
        if let formattedPrice = numberFormatter.string(from: NSNumber(value: price)) {
            return formattedPrice
        }else{
            return "n.a."
        }
        
    } else {
        return "n.a."
    }
}

#Preview {
    OrderRow(order: Order(count: 5, name: "Cola 0.2l", price: "9.5"))
}
