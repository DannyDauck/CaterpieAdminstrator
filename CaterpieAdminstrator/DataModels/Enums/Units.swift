//
//  Units.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 25.03.24.
//
import Foundation

enum Units: CaseIterable {
    case palette, draft, barrel, bottle, liter, centiliter, milliliter, gram, kilo, package, kolli, piece
    
    func tag() -> String {
        switch self {
        case .palette:
            return "Palette"
        case .draft:
            return "Kiste"
        case .bottle:
            return "Flasche"
        case .liter:
            return "Liter"
        case .centiliter:
            return "Centiliter"
        case .milliliter:
            return "Milliliter"
        case .gram:
            return "Gramm"
        case .kilo:
            return "Kilo"
        case .package:
            return "Packung"
        case .kolli:
            return "Kolli"
        case .piece:
            return "Stück"
        case .barrel:
            return "Fass"
        }
    }
    
    func isACalculatableValue() -> Bool {
            switch self {
            case .liter, .centiliter, .milliliter, .gram, .kilo, .piece:
                return true
            default:
                return false
            }
        }
}
