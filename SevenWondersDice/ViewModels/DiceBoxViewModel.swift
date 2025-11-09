//
//  DiceBoxViewModel.swift
//  SevenWondersDice
//
//  Manages the state of the dice box and rolling logic
//

import Foundation
import Combine

@MainActor
class DiceBoxViewModel: ObservableObject {
    @Published var quadrantDice: [Quadrant: [Die]] = [:]
    @Published var activeDice: Set<DiceColor> = []
    @Published var hasRolled = false
    @Published var isRolling = false

    // Dice that are always active
    let alwaysActiveDice: Set<DiceColor> = [.yellow, .green, .red, .blue]

    // Selectable dice (user must pick exactly 3)
    let selectableDice: Set<DiceColor> = [.gray1, .gray2, .gray3, .black, .white, .purple]

    var selectedSelectableDice: Set<DiceColor> {
        activeDice.intersection(selectableDice)
    }

    var hasValidSelection: Bool {
        selectedSelectableDice.count == 3
    }

    init() {
        // Initialize with always-active dice plus default three gray dice
        activeDice = alwaysActiveDice.union([.gray1, .gray2, .gray3])
    }

    func toggleDie(_ color: DiceColor) {
        // Cannot toggle always-active dice
        if alwaysActiveDice.contains(color) {
            return
        }

        // Handle selectable dice (gray and unlockable)
        if selectableDice.contains(color) {
            if activeDice.contains(color) {
                // Deselect the die
                activeDice.remove(color)
            } else {
                // Select the die (allow selecting any number)
                activeDice.insert(color)
            }
        }
    }

    func rollDice() {
        guard !activeDice.isEmpty, !isRolling else { return }

        Task {
            isRolling = true

            // Number of iterations for the rolling animation
            let iterations = Int.random(in: 7...10)

            for iteration in 0..<iterations {
                // Perform a single roll
                performSingleRoll()

                // Calculate delay with easing (progressively slower)
                if iteration < iterations - 1 {
                    let progress = Double(iteration) / Double(iterations - 1)
                    // Ease out: slower at the end
                    let easedProgress = 1 - pow(1 - progress, 3)
                    let baseDelay: UInt64 = 80_000_000 // 80ms in nanoseconds
                    let maxDelay: UInt64 = 250_000_000 // 250ms in nanoseconds
                    let delay = baseDelay + UInt64(easedProgress * Double(maxDelay - baseDelay))

                    try? await Task.sleep(nanoseconds: delay)
                }
            }

            isRolling = false
        }
    }

    private func performSingleRoll() {
        // Clear previous results
        quadrantDice = [:]

        // Create dice with random faces and randomly distribute to quadrants
        for color in activeDice {
            let randomFace = Int.random(in: 0..<color.faceCount)
            let randomQuadrant = Quadrant.allCases.randomElement()!

            // Get available positions for this quadrant
            let availablePositions = getAvailablePositions(for: randomQuadrant)

            // Get positions already used in this quadrant
            let usedPositions = quadrantDice[randomQuadrant]?.map { ($0.gridRow, $0.gridCol) } ?? []

            // Filter out used positions
            let openPositions = availablePositions.filter { pos in
                !usedPositions.contains(where: { $0 == pos })
            }

            // Pick a random open position (should always have one since max 7 dice and 8 positions per quadrant)
            if let position = openPositions.randomElement() {
                let die = Die(color: color, faceIndex: randomFace, gridRow: position.0, gridCol: position.1)
                quadrantDice[randomQuadrant, default: []].append(die)
            }
        }

        hasRolled = true
    }

    // Returns available positions for a quadrant (excluding the corner)
    private func getAvailablePositions(for quadrant: Quadrant) -> [(Int, Int)] {
        var positions: [(Int, Int)] = []
        for row in 0..<3 {
            for col in 0..<3 {
                positions.append((row, col))
            }
        }

        // Remove the corner position based on quadrant
        switch quadrant {
        case .zero:  // Top-left quadrant - remove top-left corner
            positions.removeAll { $0.0 == 0 && $0.1 == 0 }
        case .one:   // Top-right quadrant - remove top-right corner
            positions.removeAll { $0.0 == 0 && $0.1 == 2 }
        case .two:   // Bottom-right quadrant - remove bottom-right corner
            positions.removeAll { $0.0 == 2 && $0.1 == 2 }
        case .three: // Bottom-left quadrant - remove bottom-left corner
            positions.removeAll { $0.0 == 2 && $0.1 == 0 }
        }

        return positions
    }

    func reset() {
        quadrantDice = [:]
        hasRolled = false
    }
}
