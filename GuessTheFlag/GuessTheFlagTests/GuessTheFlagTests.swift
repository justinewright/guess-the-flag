//
//  GuessTheFlagTests.swift
//  GuessTheFlagTests
//
//  Created by Justine Wright on 2021/05/19.
//

import XCTest
@testable import GuessTheFlag

class GuessTheFlagTests: XCTestCase {
    let quizBrain: QuizBrain
    
    override func setUpWithError() throws {
        quizBrain = QuizBrain()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        quizBrain  = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testNextQuestionIncrements
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
