//
//  TriviaViewModel.swift
//  Trivia Game
//
//  Created by Bender on 3/27/24.
//

// TriviaViewModel.swift

import Foundation
import SwiftUI

class TriviaViewModel: ObservableObject {
    @Published var questions: [Question] = []

    func fetchTriviaQuestions() {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }

            let decoder = JSONDecoder()

            if let triviaResponse = try? decoder.decode(TriviaResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.questions = triviaResponse.results
                }
            }
        }.resume()
    }
}
