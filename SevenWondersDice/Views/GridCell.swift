//
//  GridCell.swift
//  SevenWondersDice
//
//  Represents a single cell in the 3x3 quadrant grid
//

import SwiftUI

struct GridCell: View {
    let row: Int
    let col: Int
    let quadrant: Quadrant
    let die: Die?
    let cellSize: CGFloat

    var isCornerCell: Bool {
        switch quadrant {
        case .zero: return row == 0 && col == 0  // Top-left
        case .one: return row == 0 && col == 2   // Top-right
        case .two: return row == 2 && col == 2   // Bottom-right
        case .three: return row == 2 && col == 0 // Bottom-left
        }
    }

    var body: some View {
        ZStack {
            if isCornerCell {
                // Corner cell - show cost number
                Text("\(quadrant.cost)")
                    .font(.system(size: cellSize * 0.5, weight: .bold))
                    .foregroundColor(.primary.opacity(0.4))
            } else if let die = die {
                // Cell has a die
                DieImageView(die: die, maxSize: cellSize - 4)
            } else {
                // Empty cell - show subtle grid
                Rectangle()
                    .fill(Color.clear)
                    .overlay(
                        Rectangle()
                            .stroke(Color.primary.opacity(0.1), lineWidth: 0.5)
                    )
            }
        }
        .frame(width: cellSize, height: cellSize)
    }
}

#Preview {
    HStack(spacing: 0) {
        GridCell(
            row: 0,
            col: 0,
            quadrant: .zero,
            die: nil,
            cellSize: 80
        )
        GridCell(
            row: 0,
            col: 1,
            quadrant: .zero,
            die: Die(color: .blue, faceIndex: 0, gridRow: 0, gridCol: 1),
            cellSize: 80
        )
    }
}
