//
//  QuizBrain.swift
//  GuessTheFlag
//
//  Created by Justine Wright on 2021/05/20.
//

import Foundation
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices[0...3].contains(index) ? self[index] : nil
    }
}

class QuizBrain{
    private var countries = [
        "estonia",
        "france",
        "germany",
        "ireland",
        "italy",
        "monaco",
        "nigeria",
        "poland",
        "russia",
        "spain",
        "uk",
        "us"
    ]
    private var maxQuestionCount = 10
    private var questionNumber = 0
    private(set) var score = 0
    private lazy var correctAnswer = 0
    private var numberOfChoices = 4
    
    init() {
        nextQuestion()
        questionNumber = 0
    }
    
    func nextQuestion() {
        questionNumber += 1
        correctAnswer = Int.random(in: 0 ... numberOfChoices - 1)
        countries.shuffle()
    }
    
    var correctAnswerText: String {
        return countries[correctAnswer].uppercased()
    }
    
    var correctAnswerIndex: Int {
        correctAnswer
    }
    
    func checkAnswer(answer: Int) -> Bool {
        let isCorrect = countries[safe: correctAnswer] == countries[answer]
        score += isCorrect ? 1 : -1
        return isCorrect
    }
    
    func getCountryAtIndex(index: Int) -> String{
        let country = countries[safe: index] ?? ""
        return country
    }
    
    var progress: Float {
        return Float(questionNumber)/Float(maxQuestionCount)
    }
    
    var isGameRunning: Bool {
        return questionNumber+1 < maxQuestionCount
    }
    
    func reset() {
        nextQuestion()
        score = 0
        questionNumber = 0
    }
}
