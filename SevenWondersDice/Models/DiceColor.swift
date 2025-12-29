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

    /// Returns the image name for the representative face used in dice selection
    var representativeImageName: String {
        switch self {
        case .gray1: return "IMG_0039"  // Face that appears twice in gray1
        case .gray2: return "IMG_0040"  // Face that appears twice in gray2
        case .gray3: return "IMG_0043"  // Face that appears twice in gray3
        case .black: return "IMG_0066"  // First face
        case .white: return "IMG_0073"  // First face
        case .purple: return "IMG_0060" // First face
        case .blue: return "IMG_0045"   // First face
        case .green: return "IMG_0051"  // First face
        case .red: return "IMG_0057"    // First face
        case .yellow: return "IMG_0054" // First face
        }
    }

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
