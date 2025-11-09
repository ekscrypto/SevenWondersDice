//
//  Die.swift
//  SevenWondersDice
//
//  Represents a single die in the game
//

import Foundation

struct Die: Identifiable, Hashable {
    let id = UUID()
    let color: DiceColor
    let faceIndex: Int  // 0-based index for the current face
    let gridRow: Int    // 0-2 for position in 3x3 grid
    let gridCol: Int    // 0-2 for position in 3x3 grid

    var imageName: String {
        // Images are numbered 1-based in folders
        let imageNumber = faceIndex + 1
        return "IMG_\(String(format: "%04d", getImageNumber(for: color, index: imageNumber)))"
//        return "\(color.folderName)/IMG_\(String(format: "%04d", getImageNumber(for: color, index: imageNumber)))"
    }

    // Map the logical face index to actual image numbers
    private func getImageNumber(for color: DiceColor, index: Int) -> Int {
        switch color {
        case .black:
            let numbers = [66, 67, 68, 70, 71, 72]
            return numbers[index - 1]
        case .blue:
            let numbers = [45, 46, 47, 48, 49, 50]
            return numbers[index - 1]
        case .gray1:
            let numbers = [39, 40, 41, 42, 43, 39]
            return numbers[index - 1]
        case .gray2:
            let numbers = [39, 40, 40, 42, 43, 44]
            return numbers[index - 1]
        case .gray3:
            let numbers = [39, 40, 41, 43, 43, 44]
            return numbers[index - 1]
        case .green:
            let numbers = [51, 52, 53, 51, 52, 53]
            return numbers[index - 1]
        case .purple:
            let numbers = [60, 61, 62, 63, 64, 65]
            return numbers[index - 1]
        case .red:
            let numbers = [57, 58, 59, 57, 58, 59]
            return numbers[index - 1]
        case .white:
            let numbers = [73, 74, 75, 76, 77, 73]
            return numbers[index - 1]
        case .yellow:
            let numbers = [54, 55, 56, 54, 55, 56]
            return numbers[index - 1]
        }
    }
}
