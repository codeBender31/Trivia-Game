import SwiftUI

struct OptionsView: View {
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
                        Slider(value: $numberOfQuestions, in: 5...50, step: 1)
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
                    NavigationLink(destination: GameView(
                        // Initialize GameView with the selected options.
                        // You'll need to modify GameView to accept and use these options.
                    )) {
                        Text("Start Game")
                    }
                }
            }
            .navigationBarTitle("Trivia Options")
        }
    }
}

// Sample Enums for Categories, Difficulties, and Question Types
enum Category: String, CaseIterable, Identifiable {
    case general = "General Knowledge"
    case science = "Science"
    var id: String { self.rawValue }
}

enum Difficulty: String, CaseIterable, Identifiable {
    case easy = "Easy"
    case medium = "Medium"
    var id: String { self.rawValue }
}

enum QuestionType: String, CaseIterable, Identifiable {
    case multipleChoice = "Multiple Choice"
    case trueFalse = "True/False"
    var id: String { self.rawValue }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView()
    }
}
