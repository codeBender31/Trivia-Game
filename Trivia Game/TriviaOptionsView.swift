//
//  TriviOptionsView.swift
//  Trivia Game
//
//  Created by Bender on 3/27/24.
//

import SwiftUI

struct TriviaOptionsView: View {
    @ObservedObject var viewModel: TriviaViewModel

    var body: some View {
        Form {
            Section(header: Text("Game Options")) {
                Stepper("Number of Questions: \(viewModel.amount)", value: $viewModel.amount, in: 1...50)
                Picker("Difficulty", selection: $viewModel.difficulty) {
                    ForEach(["easy", "medium", "hard", ""], id: \.self) {
                        Text($0.capitalized).tag($0)
                    }
                }
                Picker("Type", selection: $viewModel.type) {
                    Text("Any").tag("")
                    Text("Multiple Choice").tag("multiple")
                    Text("True/False").tag("boolean")
                }
                // Extend this Picker for Category if needed, similar to above
            }

            Button("Start Game") {
                viewModel.fetchTriviaQuestions()
            }
        }
        .navigationTitle("Trivia Options")
    }
}
