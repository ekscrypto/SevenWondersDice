//
//  ContentView.swift
//  SevenWondersDice
//
//  Main view for the dice rolling app
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DiceBoxViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                // Ancient parchment-like background
                Color(red: 0.96, green: 0.95, blue: 0.88)
                    .ignoresSafeArea()

                if viewModel.hasRolled {
                    DiceResultsView(viewModel: viewModel)
                } else {
                    DiceSetupView(viewModel: viewModel)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
