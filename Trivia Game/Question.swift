//
//  Question.swift
//  Trivia Game
//
//  Created by Bender on 3/27/24.
//

import Foundation
import SwiftUI

struct TriviaResponse: Codable {
    let results: [Question]
}

struct Question: Codable, Identifiable {
    let id = UUID()
    var category: String
    var type: String
    var difficulty: String
    var question: String
    var correctAnswer: String
    var incorrectAnswers: [String]

    private enum CodingKeys: String, CodingKey {
        case category, type, difficulty, question, correctAnswer = "correct_answer", incorrectAnswers = "incorrect_answers"
    }

    var allAnswers: [String] {
        var all = incorrectAnswers
        all.append(correctAnswer)
        return all.shuffled()
    }
}

