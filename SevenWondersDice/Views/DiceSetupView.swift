//
//  DiceSetupView.swift
//  SevenWondersDice
//
//  View for selecting active dice and initiating a roll
//

import SwiftUI

struct DiceSetupView: View {
    @ObservedObject var viewModel: DiceBoxViewModel

    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > geometry.size.height {
                // Horizontal layout for landscape
                VStack(spacing: 20) {
                    Text("7 Wonders Dice")
                        .font(.system(size: 28, weight: .bold, design: .serif))
                        .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                    Text("Unofficial - by fans, for fans")
                        .font(.system(size: 12, weight: .regular, design: .serif))
                        .italic()
                        .foregroundColor(Color(red: 0.5, green: 0.35, blue: 0.25))

                    HStack(spacing: 20) {
                        // Column 1: Always Active
                        VStack(spacing: 20) {
                            VStack(spacing: 12) {
                                Text("Always Active")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)

                                VStack(spacing: 15) {
                                    ForEach(Array(viewModel.alwaysActiveDice).sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { color in
                                        VStack(spacing: 4) {
                                            Image(color.representativeImageName)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 40, height: 40)
                                                .cornerRadius(6)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 6)
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

                            Spacer()
                        }
                        .frame(maxWidth: geometry.size.width * 0.25)

                    // Column 2: Selectable Dice
                    VStack(spacing: 20) {
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

                        Spacer()
                    }
                    .frame(maxWidth: geometry.size.width * 0.45)

                    // Column 3: Roll Button
                    VStack {
                        Spacer()

                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                viewModel.rollDice()
                            }
                        }) {
                            VStack(spacing: 8) {
                                Image(systemName: "dice.fill")
                                    .font(.title)
                                Text("Roll Dice")
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    colors: [Color.blue, Color.purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                            .shadow(radius: 5)
                        }
                        .disabled(viewModel.activeDice.isEmpty || viewModel.isRolling || !viewModel.hasValidSelection)
                        .opacity(viewModel.activeDice.isEmpty || viewModel.isRolling || !viewModel.hasValidSelection ? 0.5 : 1.0)

                        Spacer()
                    }
                    .frame(maxWidth: geometry.size.width * 0.25)
                    }
                }
                .padding()
            } else {
                // Vertical layout for portrait
                VStack(spacing: 30) {
                    Text("7 Wonders Dice")
                        .font(.system(size: 36, weight: .bold, design: .serif))
                        .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                    Text("Unofficial - by fans, for fans")
                        .font(.system(size: 14, weight: .regular, design: .serif))
                        .italic()
                        .foregroundColor(Color(red: 0.5, green: 0.35, blue: 0.25))

                    DiceSelectionView(viewModel: viewModel)

                    Spacer()

                    VStack(spacing: 10) {
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                viewModel.rollDice()
                            }
                        }) {
                            HStack {
                                Image(systemName: "dice.fill")
                                Text("Roll Dice")
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    colors: [Color.blue, Color.purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                            .shadow(radius: 5)
                        }
                        .disabled(viewModel.activeDice.isEmpty || viewModel.isRolling || !viewModel.hasValidSelection)
                        .opacity(viewModel.activeDice.isEmpty || viewModel.isRolling || !viewModel.hasValidSelection ? 0.5 : 1.0)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    DiceSetupView(viewModel: DiceBoxViewModel())
}
