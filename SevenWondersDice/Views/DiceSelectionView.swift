//
//  DiceSelectionView.swift
//  SevenWondersDice
//
//  View for selecting which dice are active
//

import SwiftUI

struct DiceSelectionView: View {
    @ObservedObject var viewModel: DiceBoxViewModel

    let columns = [
        GridItem(.adaptive(minimum: 80, maximum: 100), spacing: 15)
    ]

    var body: some View {
        VStack(spacing: 20) {
            // Always Active Dice Section
            VStack(spacing: 12) {
                Text("Always Active")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)

                HStack(spacing: 15) {
                    ForEach(Array(viewModel.alwaysActiveDice).sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { color in
                        VStack(spacing: 4) {
                            Circle()
                                .fill(color.displayColor)
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Circle()
                                        .stroke(Color.black.opacity(0.2), lineWidth: 2)
                                )
                                .shadow(radius: 3)

                            Text(color.rawValue.capitalized)
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .padding()
            .background(Color.green.opacity(0.1))
            .cornerRadius(12)

            Divider()

            // Gray Dice Section
            VStack(spacing: 12) {
                Text("Gray Dice")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)

                HStack(spacing: 20) {
                    ForEach([DiceColor.gray1, .gray2, .gray3], id: \.self) { color in
                        DiceToggleButton(
                            color: color,
                            isActive: viewModel.activeDice.contains(color),
                            isAlwaysActive: false,
                            isUnlockable: false,
                            isGray: true,
                            isPendingUnlock: false
                        ) {
                            viewModel.toggleDie(color)
                        }
                    }
                }
            }

            // Unlockable Dice Section
            VStack(spacing: 12) {
                Text("Unlockable Dice")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)

                HStack(spacing: 20) {
                    ForEach([DiceColor.black, .white, .purple], id: \.self) { color in
                        DiceToggleButton(
                            color: color,
                            isActive: viewModel.activeDice.contains(color),
                            isAlwaysActive: false,
                            isUnlockable: true,
                            isGray: false,
                            isPendingUnlock: false
                        ) {
                            viewModel.toggleDie(color)
                        }
                    }
                }
            }

            // Show selection count instruction
            if !viewModel.hasValidSelection {
                VStack(spacing: 8) {
                    Text("You must pick exactly three dice")
                        .font(.headline)
                        .foregroundColor(.orange)
                    Text("Selected: \(viewModel.selectedSelectableDice.count)/3")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(12)
            }
        }
    }
}

struct LegendItem: View {
    let color: Color
    let text: String

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
            Text(text)
        }
    }
}

struct DiceToggleButton: View {
    let color: DiceColor
    let isActive: Bool
    let isAlwaysActive: Bool
    let isUnlockable: Bool
    let isGray: Bool
    let isPendingUnlock: Bool
    let action: () -> Void

    var indicatorColor: Color? {
        if isAlwaysActive {
            return .green.opacity(0.3)
        } else if isUnlockable {
            return .blue.opacity(0.3)
        }
        return nil
    }

    var shouldHighlight: Bool {
        isPendingUnlock && isGray && isActive
    }

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    // Highlight background for gray dice during unlock selection
                    if shouldHighlight {
                        Circle()
                            .fill(Color.orange.opacity(0.3))
                            .frame(width: 60, height: 60)
                            .overlay(
                                Circle()
                                    .stroke(Color.orange, lineWidth: 3)
                            )
                    }

                    Circle()
                        .fill(color.displayColor)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Circle()
                                .stroke(Color.black.opacity(0.2), lineWidth: 2)
                        )
                        .overlay(
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .opacity(isActive ? 1 : 0)
                        )
                        .overlay(
                            // Indicator ring for always-active or unlockable dice
                            Circle()
                                .stroke(indicatorColor ?? .clear, lineWidth: 4)
                                .padding(-4)
                        )
                        .shadow(radius: isActive ? 5 : 2)
                        .opacity(isAlwaysActive || isUnlockable ? 1.0 : (isActive ? 1.0 : 0.6))
                }

                Text(color.rawValue.capitalized)
                    .font(.caption)
                    .fontWeight(isActive ? .bold : .regular)
                    .foregroundColor(isActive ? .primary : .secondary)
            }
        }
        .disabled(isAlwaysActive)
        .scaleEffect(isActive ? 1.1 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isActive)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: shouldHighlight)
    }
}

#Preview {
    DiceSelectionView(viewModel: DiceBoxViewModel())
}
