//
//  QuizBrain.swift
//  GuessTheFlag
//
//  Created by Justine Wright on 2021/05/20.
//

import Foundation

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

    
    init() {
        nextQuestion()
        questionNumber = 0
    }
    
    func nextQuestion() {
        questionNumber += 1
        correctAnswer = Int.random(in: 0...3)
        countries.shuffle()
    }
    
    var correctAnswerText: String {
        return countries[correctAnswer].uppercased()
    }
    
    var correctAnswerIndex: Int {
        correctAnswer
    }
    
    func checkAnswer(answer:Int) -> Bool {
        let isCorrect = countries[correctAnswer] == countries[answer]
        score += isCorrect ? 1 : -1
        return isCorrect
    }
    
    func getCountryAtIndex(index:Int)->String{
        return countries[index]
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
