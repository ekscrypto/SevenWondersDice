//
//  DiceResultsView.swift
//  SevenWondersDice
//
//  View for displaying rolled dice results
//

import SwiftUI

struct DiceResultsView: View {
    @ObservedObject var viewModel: DiceBoxViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var isLandscape: Bool {
        horizontalSizeClass == .regular && verticalSizeClass == .compact
    }

    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > geometry.size.height {
                // Horizontal layout for landscape
                HStack(spacing: 20) {
                    QuadrantGridView(quadrantDice: viewModel.quadrantDice)
                        .frame(maxHeight: .infinity)

                    VStack(spacing: 20) {
                        Spacer()

                        Button(action: {
                            viewModel.rollDice()
                        }) {
                            VStack(spacing: 8) {
                                Image(systemName: "dice.fill")
                                    .font(.title)
                                Text("Roll")
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 120)
                            .background(
                                LinearGradient(
                                    colors: [Color.blue, Color.purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                        }
                        .disabled(viewModel.isRolling)
                        .opacity(viewModel.isRolling ? 0.5 : 1.0)

                        Button(action: {
                            viewModel.reset()
                        }) {
                            VStack(spacing: 8) {
                                Image(systemName: "gearshape.fill")
                                    .font(.title)
                                Text("Select Dice")
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 120)
                            .background(Color.gray.opacity(0.8))
                            .cornerRadius(12)
                        }

                        Spacer()
                    }
                    .padding(.trailing)
                }
            } else {
                // Vertical layout for portrait
                VStack(spacing: 20) {
                    QuadrantGridView(quadrantDice: viewModel.quadrantDice)

                    HStack(spacing: 15) {
                        Button(action: {
                            viewModel.rollDice()
                        }) {
                            HStack {
                                Image(systemName: "dice.fill")
                                Text("Roll")
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
                        }
                        .disabled(viewModel.isRolling)
                        .opacity(viewModel.isRolling ? 0.5 : 1.0)

                        Button(action: {
                            viewModel.reset()
                        }) {
                            HStack {
                                Image(systemName: "gearshape.fill")
                                Text("Select Dice")
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.8))
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    let viewModel = DiceBoxViewModel()
    viewModel.quadrantDice = [
        .zero: [Die(color: .black, faceIndex: 0, gridRow: 1, gridCol: 1)],
        .one: [
            Die(color: .blue, faceIndex: 1, gridRow: 0, gridCol: 1),
            Die(color: .red, faceIndex: 0, gridRow: 1, gridCol: 0)
        ],
        .two: [Die(color: .green, faceIndex: 2, gridRow: 2, gridCol: 1)],
        .three: []
    ]
    return DiceResultsView(viewModel: viewModel)
}
