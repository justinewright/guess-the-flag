//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Justine Wright on 2021/05/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var buttons: [UIButton]!

    @IBOutlet weak var countryText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressText: UILabel!
    var quizBrain = QuizBrain()
//    private lazy var countries = [String]() // lazy = delay instantiation until required
//    private lazy var score = 0
//    private lazy var correctAnswer = 0
//    private var maxQuestionCount = 10
//    private var currentQuestionCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateUI
        applyStyleToButtons()
        updateUI()
    }

    private func applyStyleToButtons(){
        for button in buttons{
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.cornerRadius = 5
            button.tintColor = UIColor.white
            button.layer.masksToBounds = true
        }
        
        // UIColor (red:, green:, blue:).cgColour
        
    }
    
    private func allDeselect(){
        for button in buttons{
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.borderWidth = 1
            button.alpha = 0.75
        }
    }
    
    private func updateUI(){
        setScoreText()
        allDeselect()
        updateProgressBar()
        setButtonImages()
        setCorrectCountryText()
    }
    
    // UIAlertAction needed for alertController
    private func askQuestion(action: UIAlertAction! = nil)->Void{
        //for: .normal -> takes in parameter for state of button
        // .normal -> from a struct
        quizBrain.nextQuestion()
        updateUI()
    }
    
    private func setCorrectCountryText(){
        countryText.text = "\(quizBrain.getCorrectAnswerText())"
    }
    
    private func setScoreText(){
        title = "Your Score: \(quizBrain.getScore())/10"
    }
    
    private func setButtonImages(){
        var index = 0
        for button in buttons{
            let name = quizBrain.getCountryAtIndex(index: index)
            button.setImage(UIImage(named: name), for: .normal)
            index += 1
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let correctAnswer = quizBrain.checkAnswer(answer: sender.tag)
        highlightRightFlag()
        if correctAnswer {
            makeRightAnswerAlert()
        }
        else{
            highlightBadFlag(actualAnswer: sender.tag)
            makeWrongAnswerAlert(actualAnswer: sender.tag)
        }
    }
    
    private func makeRightAnswerAlert(){
        let title = "Correct"
        let msg = ["Good job! :)", "Fabulous! :)", "Amazing! :)"].randomElement()!
        showAlert(title: title, message:  msg)
    }
    
    private func makeWrongAnswerAlert(actualAnswer: Int){
        highlightBadFlag(actualAnswer: actualAnswer)
        let title = "Wrong"
        let msg = "You guessed \(quizBrain.getCountryAtIndex(index: actualAnswer)) :("
        showAlert(title: title, message:  msg)
    }
 
    private func showAlert(title:String, message: String = "Good job!"){
        if quizBrain.isGameRunning(){
            showQuestionFeedbackAlert(title: title, message: message)
        }else{
            showFinalAlert(title: title)
        }
    }
    
    private func showQuestionFeedbackAlert(title:String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(alertController, animated: true)
    }
    
    private func showFinalAlert(title:String ){
        let alertController = UIAlertController(title: title, message: "Your final score is \(quizBrain.getScore())/10", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Quit", style: .default, handler: quit))
        
        present(alertController, animated: true)
    }
    
    private func highlightBadFlag(actualAnswer:Int){
        buttons[actualAnswer].layer.borderColor = UIColor.red.cgColor
        buttons[actualAnswer].alpha = 1
        buttons[actualAnswer].layer.borderWidth = 5
        
    }
    
    private func highlightRightFlag(){
        let correctAnswerIndex = quizBrain.getCorrectAnswerIndex()
        buttons[correctAnswerIndex].layer.borderColor = UIColor.green.cgColor
        buttons[correctAnswerIndex].alpha = 1
        buttons[correctAnswerIndex].layer.borderWidth = 5
    }
    
    private func quit(action: UIAlertAction! = nil){
        exit(0)
    }

    private func updateProgressBar(){
        let percentage = quizBrain.getProgress()
        updateProgressBar(percentage: percentage)
        updateProgressText(percentage: percentage)
    }
    
    private func updateProgressBar(percentage: Float){
        progressBar.progress = percentage
    }
    
    private func updateProgressText(percentage: Float){
        progressText.text = "\(Int(round(percentage*100.00) ))%"
    }
    
    //ca layer = core animation layer
    
    //Layer order:
    // uiview uikit
    // uicolor
    // ca cg
    
    // 1 Challenges
    // 1. refactor code
    // 2. add this to github
    // 3. pull request
    
    // 2 Challenge
    // + show score in navigation bar
    // + keep track of how many questions have been asked
    // +max queestions 10
    // +10 -> final alert controller
    
    // 3 challenge
    // +mistake
    // +tell them what flag they selected, and what flag was right
}

