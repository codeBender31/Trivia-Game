//
//  ContentView.swift
//  Testing
//
//  Created by Bender on 3/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var questions: [Question] = []
    @State private var jsonData: String = ""
//    let numberOfQuestions: Int = 10
//    let selectedCategory: Category = .general
//    let selectedDifficulty: Difficulty = .medium
//    let selectedQuestionType: QuestionType = .multipleChoice
    var body: some View {
        ScrollView {
            VStack {
                if questions.isEmpty {
                    Text("Loading...")
                        .padding()
                } else {
                    ForEach(questions) { question in
                        VStack(alignment: .leading) {
                            Text(" \(question.question)").font(.headline)
                          
                            //Correct Answer
                            Text(" \(question.correctAnswer)").font(.headline)
                            //Incorrect answer
                            Text(" \(question.incorrectAnswers.joined(separator: "\n"))").font(.headline)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                           .padding(.vertical, 8)
                    }
                }
            }
            .onAppear(perform: { // <-- Add onAppear modifier
                // Create a Task instance
                Task {
                    await fetchQuestions()
                }
            })
            
        }
    }
    
    func fetchQuestions() async{
        let url = URL(string: "https://opentdb.com/api.php?amount=10&category=11&difficulty=medium&type=multiple")!
        // Wrap in do/catch since URLSession async can throw errors
        do{
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(TriviaResponse.self, from: data)
            
            // Update your questions array on the main thread
            DispatchQueue.main.async {
                self.questions = decodedResponse.results
            }
            //PlaceHolder
        }catch {
            print(error.localizedDescription)
        }
    }
}
// A view representing an answer button
struct AnswerButton: View {
    let answer: String
    let question: Question

    var body: some View {
        Button(action: {
            // Handle answer selection here...
            print("Selected answer: \(answer)")
        }) {
            Text(answer)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.black)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }


    
    // Perform an asynchronous data request using URLSession
//                        let (data, _) = try await URLSession.shared.data(from: url)
//
//                        // Print the JSON
//                        // Convert data to JSON object
//                        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
//                        // Convert JSON object back to pretty-printed data
//                        let prettyPrintedData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
//
//                        // Convert data to string for printing
//                        if let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8) {
//                            print(prettyPrintedString)
//                 self.jsonData = prettyPrintedString
//                        }


//                            Text("Category: \(question.category)").font(.headline)
//                            Text("Type: \(question.type)").font(.subheadline)
//                            Text("Difficulty: \(question.difficulty)").font(.headline)
