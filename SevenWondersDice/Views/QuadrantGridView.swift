//
//  QuadrantGridView.swift
//  SevenWondersDice
//
//  Displays the four quadrants with rolled dice
//

import SwiftUI

struct QuadrantGridView: View {
    let quadrantDice: [Quadrant: [Die]]

    var body: some View {
        GeometryReader { geometry in
            // Use the smaller dimension to make it a perfect square
            let size = min(geometry.size.width, geometry.size.height)
            let quadrantSize = (size - 4) / 2  // Subtract gap space (2px * 2 gaps = 4)

            VStack(spacing: 2) {
                HStack(spacing: 2) {
                    // Top-left: 0 coins
                    QuadrantView(
                        quadrant: .zero,
                        dice: quadrantDice[.zero] ?? [],
                        size: quadrantSize
                    )
                    // Top-right: 1 coin
                    QuadrantView(
                        quadrant: .one,
                        dice: quadrantDice[.one] ?? [],
                        size: quadrantSize
                    )
                }
                HStack(spacing: 2) {
                    // Bottom-left: 3 coins
                    QuadrantView(
                        quadrant: .three,
                        dice: quadrantDice[.three] ?? [],
                        size: quadrantSize
                    )
                    // Bottom-right: 2 coins
                    QuadrantView(
                        quadrant: .two,
                        dice: quadrantDice[.two] ?? [],
                        size: quadrantSize
                    )
                }
            }
            .frame(width: size, height: size)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding()
    }
}

#Preview {
    QuadrantGridView(quadrantDice: [
        .zero: [Die(color: .black, faceIndex: 0, gridRow: 1, gridCol: 1)],
        .one: [
            Die(color: .blue, faceIndex: 1, gridRow: 0, gridCol: 1),
            Die(color: .red, faceIndex: 0, gridRow: 1, gridCol: 0)
        ],
        .two: [Die(color: .green, faceIndex: 2, gridRow: 2, gridCol: 1)],
        .three: []
    ])
}
