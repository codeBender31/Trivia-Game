//
//  Trivia_GameApp.swift
//  Trivia Game
//
//  Created by Bender on 3/26/24.
//
//OptioinsView
import SwiftUI

struct OptionsView: View {
//    @EnvironmentObject var viewModel: TriviaView
    @State private var numberOfQuestions: Double = 10 // Using Double for Slider
    @State private var selectedCategory: Category = .general
    @State private var selectedDifficulty: Difficulty = .medium
    @State private var selectedQuestionType: QuestionType = .multipleChoice

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Game Options")) {
                    // Number of Questions Slider
                    HStack {
                        Text("Number of Questions: \(Int(numberOfQuestions))")
                        Slider(value: $numberOfQuestions, in: 5...10, step: 1)
                    }
                    
                    // Category Picker
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(Category.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    
                    // Difficulty Picker
                    Picker("Difficulty", selection: $selectedDifficulty) {
                        ForEach(Difficulty.allCases) { difficulty in
                            Text(difficulty.rawValue).tag(difficulty)
                        }
                    }
                    
                    // Question Type Picker
                    Picker("Question Type", selection: $selectedQuestionType) {
                        ForEach(QuestionType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: ContentView()) {
                        Text("Start Game").foregroundColor(.blue)
                    }
                }
            }
            .navigationBarTitle("Trivia Game Options")
        }
    }
}

// Sample Enums for Categories, Difficulties, and Question Types
enum Category: String, CaseIterable, Identifiable {
    case general = "General Knowledge"
    case science = "Science"
    case computers = "Computers"
    case mathematics = "Mathematics"
    case mythology = "Mythology"
    case sports = "Sports"
    case geography = "Geography"
    case history = "History"
    case politics = "Politics"
    case art = "Art"
    case celebrities = "Celebrities"
    case animals = "Animals"
    case vehicles = "Vehicles"
    case comics = "Comics"
    case animeManga = "Anime & Manga"
    case cartoonsAnimations = "Cartoons & Animations"
    case film = "Entertainment: Film"
    case music = "Entertainment: Music"
    case television = "Entertainment: Television"
    case videoGames = "Entertainment: Video Games"
    var id: String { self.rawValue }
}

enum Difficulty: String, CaseIterable, Identifiable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    var id: String { self.rawValue }
}

enum QuestionType: String, CaseIterable, Identifiable {
    case multipleChoice = "Multiple Choice"
    case trueFalse = "True/False"
    var id: String { self.rawValue }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
//        OptionsView().environmentObject(ContentView())
        OptionsView()
    }
}
