//
//  ColorManager.swift
//  Caterpie
//
//  Created by Danny Dauck on 06.03.24.
//

import Foundation
import SwiftUI

class ColorManager: ObservableObject{
    
    static let shared = ColorManager()
    
    private init(){}
    
    var primary = Color.black
    var backgroundURL = "https://static.bnn.de/karlsruhe/cafezero1/alternates/LANDSCAPE_16x9_688/cafezero1"
    
    var foregroundActive = LinearGradient(colors: [.green, .indigo], startPoint: .bottomLeading, endPoint: .topTrailing)
    var symbolActive = Color.green
    
    var btnBgInactive = LinearGradient(colors: [.gray, .black], startPoint: .bottomLeading, endPoint: .topTrailing)
    var btnBgActive = LinearGradient(colors: [.black, .gray], startPoint: .bottomLeading, endPoint: .topTrailing)
    
    var txtImportant = Color.yellow
    
    var shadow = Color.white
    var linearShadow = LinearGradient(colors: [.white, .black], startPoint: .leading, endPoint: .trailing)
    
    var menueSubItemBG = LinearGradient(colors: [.white, .gray], startPoint: .bottomLeading, endPoint: .topTrailing)
    var menueSubItemBGInversed = LinearGradient(colors: [.gray, .white], startPoint: .bottomLeading, endPoint: .topTrailing)
    
    var exceptionGradient = LinearGradient(colors: [.red, .red, .orange, .white, .red], startPoint: .bottomLeading, endPoint: .topTrailing)
    
    func getColor(_ color: String) -> Color {
        switch color.lowercased() {
        case "red":
            return .red
        case "blue":
            return .blue
        case "green":
            return .green
        case "yellow":
            return .yellow
        case "orange":
            return .orange
        case "purple":
            return .purple
        case "indigo":
            return .indigo
        case "cyan":
            return .cyan
        case "brown":
            return .brown
        case "bordeaux":
            return Color(red: 0.5, green: 0, blue: 0.2)
        default:
            return .black
        }
    }
    
}

