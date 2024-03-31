//
//  Question.swift
//  Trivia Game
//
//  Created by Bender on 3/27/24.
//
//Question.swift
//import Foundation
//import SwiftUI
//
//
// Define the TriviaResponse struct to match the JSON response structure

import Foundation

// Define your Question struct here, as previously discussed
struct Question: Codable, Identifiable{
    let id = UUID()
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    // Existing properties...
      var userAnswer: String? = nil // Add this line
    
    enum CodingKeys: String, CodingKey {
        case category, type, difficulty, question
        case correctAnswer = "correct_answer", incorrectAnswers = "incorrect_answers"
    }
}
    
struct TriviaResponse: Codable{
        let responseCode: Int
        let results: [Question]
        
        enum CodingKeys: String, CodingKey {
                case responseCode = "response_code"
                case results
            }
    }

// Computed property to shuffle and combine correct and incorrect answers
//    var allAnswers: [String] {
//        (incorrectAnswers + [correctAnswer]).shuffled()
//    }


