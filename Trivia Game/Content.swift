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
    @State private var timeRemaining = 30 // Example: 30 seconds for each question
    @State private var showScoreAlert = false
    @State private var userScore = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    let numberOfQuestions: Int = 10
//    let selectedCategory: Category = .general
//    let selectedDifficulty: Difficulty = .medium
//    let selectedQuestionType: QuestionType = .multipleChoice
    var body: some View {
        ScrollView {
            VStack {
                Text("Time Remaining: \(timeRemaining)")
                                    .font(.headline)
                                    .foregroundColor(timeRemaining > 10 ? .black : .red) // Turns red when low
                                    .padding()
                if questions.isEmpty {
                    Text("Loading...")
                        .padding()
                } else {
                    ForEach(questions) { question in
                        VStack(alignment: .leading) {
                            Text(" \(question.question)").font(.system(size: 24))
                            Spacer()
                            // Display all answers as interactive buttons
                            ForEach(question.allAnswers, id: \.self) { answer in AnswerButton(answer: answer) {
                                // Action to be performed when an answer is selected
                                print("Selected answer: \(answer)")
                            }.padding(.bottom, 2)
                            }
//                            //Correct Answer
//                            Text(" \(question.correctAnswer) ").font(.system(size: 24))
//                            //Incorrect answer
//                            Text(" \(question.incorrectAnswers.joined(separator: "\n"))").font(.system(size: 24))
                        }
                        .padding()
                        .background(Color.blue.gradient)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
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
            
        } .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                // Calculate the score or use a hardcoded value
                userScore = 7 // Example hardcoded score, replace with actual calculation if needed
                // Show the alert
                showScoreAlert = true
                // Stop the timer
                timer.upstream.connect().cancel()
            }
        }.alert("Time's Up!", isPresented: $showScoreAlert) {
            Button("OK") {
                // Here you can add any actions to take after the user dismisses the alert
                // For example, reset for a new game or navigate to a different view
            }
        } message: {
            Text("Your score is \(userScore)/\(questions.count)")
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
struct AnswerButton: View {
    let answer: String
    var action: () -> Void // This closure is executed when the button is tapped.

    var body: some View {
        Button(action: action) {
            Text(answer)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.2)) // Light gray background
                .foregroundColor(.black)
                .cornerRadius(8)
        }
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
