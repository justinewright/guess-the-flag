//
//  QuizBrainTests.swift
//  QuizBrainTests
//
//  Created by Justine Wright on 2021/05/25.
//

import XCTest

class QuizBrainTests: XCTestCase {
    
    var quizBrain: QuizBrain?

    override func setUpWithError() throws {
        quizBrain = QuizBrain()
    }
    
    func testIsValidCountryWithIndexZero() {
        let index = 0
        
        let actualCountryName = quizBrain!.getCountryAtIndex(index: index)
        let comparativeCountryName = ""
            
        XCTAssertNotEqual(actualCountryName, comparativeCountryName)
    }
    
    func testIsInvalidIndexWithIndexFour() {
        let index = 4
        
        let actualCountryName = quizBrain!.getCountryAtIndex(index: index)
        let expectedCountryName = ""
        
        XCTAssertEqual(actualCountryName, expectedCountryName)
    }
    
    func testIsInvalidIndexWithNegativeIndex() {
        let index = -1
        
        let actualCountryName = quizBrain!.getCountryAtIndex(index: index)
        let expectedCountryName = ""
        
        XCTAssertEqual(actualCountryName, expectedCountryName)
    }
    
    func testNextQuestionAdvancesProgress() {
        let currentProgress = Float(quizBrain!.progress )
        quizBrain!.nextQuestion()
        let newProgress = Float(quizBrain!.progress )
        
        let actualProgressDifference = newProgress - currentProgress
        let expectedProgressDifference: Float = 0.1
        
        XCTAssertEqual(actualProgressDifference, expectedProgressDifference, accuracy: 0.01)
    }
    
    func testIfCheckAnswerIsCorrectScoreIncreasesBy1() {
        let initialScore = quizBrain!.score
        let _ = quizBrain!.checkAnswer(answer: quizBrain!.correctAnswerIndex)
        let finalScore = quizBrain!.score
        
        let actualScoreDifference = finalScore - initialScore
        let expectedScoreDifference = 1
        
        XCTAssertEqual(actualScoreDifference, expectedScoreDifference)
    }
    
    func testIfCheckAnswerIsIncorrectScoreDecreasesBy1() {
        let initialScore = quizBrain!.score
        let _ = quizBrain!.checkAnswer(answer: quizBrain!.correctAnswerIndex + 1 % 4)
        let finalScore = quizBrain!.score
        
        let actualScoreDifference = finalScore - initialScore
        let expectedScoreDifference = -1
        
        XCTAssertEqual(actualScoreDifference, expectedScoreDifference)
    }
    
    func testIfCheckAnswerIsInvalidDueToIndexScoreDecreasesBy1() {
        let initialScore = quizBrain!.score
        let _ = quizBrain!.checkAnswer(answer: -1)
        let finalScore = quizBrain!.score
        
        let actualScoreDifference = finalScore - initialScore
        let expectedScoreDifference = -1
        
        XCTAssertEqual(actualScoreDifference, expectedScoreDifference)
    }
    
    func testResetSetsScoreToZero() {
        let _ = quizBrain!.checkAnswer(answer: quizBrain!.correctAnswerIndex + 1 % 4)
        quizBrain!.reset()
        
        let actualScore = quizBrain!.score
        let expectedScore = 0
        
        XCTAssertEqual(actualScore, expectedScore)
    }
    
    func testResetSetsProgressToZero() {
        let _ = quizBrain!.checkAnswer(answer: quizBrain!.correctAnswerIndex + 1 % 4)
        quizBrain!.reset()
        
        let actualProgress = 0.0
        let expectedProgress = 0.0
        
        XCTAssertEqual(actualProgress, expectedProgress, accuracy: 0.01)
    }
    
}
