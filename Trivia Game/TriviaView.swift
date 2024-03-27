//
//  TriviaView.swift
//  Trivia Game
//
//  Created by Bender on 3/27/24.
//

import Foundation
import SwiftUI

struct TriviaView: View {
    @StateObject var viewModel = TriviaViewModel()

    var body: some View {
        List(viewModel.questions) { question in
            VStack(alignment: .leading) {
                Text(unescapeHTML(question.question))
                    .fontWeight(.bold)
                ForEach(question.allAnswers, id: \.self) { answer in
                    Text(unescapeHTML(answer))
                        .padding(.top, 2)
                }
            }
        }
        .onAppear {
            viewModel.fetchTriviaQuestions()
        }
    }
    
    // Helper function to decode HTML entities in the question and answer strings
    func unescapeHTML(_ string: String) -> String {
        guard let data = string.data(using: .utf8) else { return string }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        return (try? NSAttributedString(data: data, options: options, documentAttributes: nil).string) ?? string
    }
}
struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a TriviaView instance
        // Since TriviaView initializes its own ViewModel, no additional setup is needed here
        TriviaView()
    }
}
