//
//  DiceColor.swift
//  SevenWondersDice
//
//  Represents the different dice colors in 7 Wonders Dice
//

import Foundation
import SwiftUI

enum DiceColor: String, CaseIterable, Identifiable {
    case black
    case blue
    case gray1
    case gray2
    case gray3
    case green
    case purple
    case red
    case white
    case yellow

    var id: String { rawValue }

    var displayColor: Color {
        switch self {
        case .black: return .black
        case .blue: return .blue
        case .gray1: return .gray
        case .gray2: return .gray
        case .gray3: return .gray
        case .green: return .green
        case .purple: return .purple
        case .red: return .red
        case .white: return Color(white: 0.95)
        case .yellow: return .yellow
        }
    }

    var faceCount: Int { 6 }
    var folderName: String {
        switch self {
        case .black: "-black"
        case .blue: "-blue"
        case .gray1: "-gray"
        case .gray2: "-gray"
        case .gray3: "-gray"
        case .green: "-green"
        case .purple: "-purple"
        case .red: "-red"
        case .white: "-white"
        case .yellow: "-yellow"
        }
    }
}
