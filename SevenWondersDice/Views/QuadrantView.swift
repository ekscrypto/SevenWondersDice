//
//  QuadrantView.swift
//  SevenWondersDice
//
//  Displays a single quadrant with its 3x3 grid
//

import SwiftUI

struct QuadrantView: View {
    let quadrant: Quadrant
    let dice: [Die]
    let size: CGFloat

    var backgroundColor: Color {
        switch quadrant {
        case .zero: return Color.green.opacity(0.2)
        case .one: return Color.blue.opacity(0.2)
        case .two: return Color.orange.opacity(0.2)
        case .three: return Color.red.opacity(0.2)
        }
    }

    var body: some View {
        ZStack {
            // Background
            backgroundColor

            // 3x3 Grid (using full quadrant size)
            let cellSize = size / 3
            VStack(spacing: 0) {
                ForEach(0..<3, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<3, id: \.self) { col in
                            GridCell(
                                row: row,
                                col: col,
                                quadrant: quadrant,
                                die: dice.first(where: { $0.gridRow == row && $0.gridCol == col }),
                                cellSize: cellSize
                            )
                        }
                    }
                }
            }
        }
        .frame(width: size, height: size)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.primary.opacity(0.3), lineWidth: 2)
        )
    }
}

#Preview {
    QuadrantView(
        quadrant: .zero,
        dice: [
            Die(color: .black, faceIndex: 0, gridRow: 1, gridCol: 1),
            Die(color: .blue, faceIndex: 1, gridRow: 0, gridCol: 1)
        ],
        size: 200
    )
}
