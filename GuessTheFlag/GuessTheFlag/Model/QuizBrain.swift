//
//  QuizBrain.swift
//  GuessTheFlag
//
//  Created by Justine Wright on 2021/05/20.
//

import Foundation

struct QuizBrain{
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
    private var score = 0
    private lazy var correctAnswer = 0

    
    init() {
        nextQuestion()
        questionNumber = 0
    }
    
    mutating func nextQuestion(){
        questionNumber += 1
        correctAnswer = Int.random(in: 0...3)
        countries.shuffle()
    }
    
    mutating func getCountryChoices()-> [String]{
        let chosenCountries = countries[...3]
        return Array(chosenCountries)
    }
    
    mutating func getCorrectAnswerText()->String{
        return countries[correctAnswer].uppercased()
    }
    
    mutating func getCorrectAnswerIndex()->Int{
        return correctAnswer
    }
    
    mutating func checkAnswer(answer:Int) -> Bool{
        let isCorrect = countries[correctAnswer] == countries[answer]
        score += isCorrect ? 1 : -1
        return isCorrect
    }
    
    func getCountryAtIndex(index:Int)->String{
        return countries[index]
    }
    
    func getProgress()->Float{
        return Float(questionNumber+1)/Float(maxQuestionCount)
    }
    
    func getScore()->Int{
        return score
    }
    
    func isGameRunning()->Bool{
        return questionNumber+1 < maxQuestionCount
    }
}
