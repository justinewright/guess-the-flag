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
    
    private lazy var countries = [String]() // lazy = delay instantiation until required
    private lazy var score = 0
    private lazy var correctAnswer = 0
    private var maxQuestionCount = 10
    private var currentQuestionCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountries()
        applyStyleToButtons()
        allDeselect()
        resetProgressBar()
        askQuestion()
    }
    
    private func loadCountries(){
        countries += [
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
        //another way to load: computed variable
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
    // UIAlertAction needed for alertController
    private func askQuestion(action: UIAlertAction! = nil)->Void{
        chooseThreeRandomCountries()
        //for: .normal -> takes in parameter for state of button
        // .normal -> from a struct
        correctAnswer = Int.random(in: 0...3)
        updateQuestionCount()
        allDeselect()
        setCorrectCountryText()
        setScore()
        updateProgress()
    }
    
    private func updateQuestionCount(){
        currentQuestionCount += 1
    }
    private func setCorrectCountryText(){
        countryText.text = "\(countries[correctAnswer].uppercased())"
    }
    private func setScore(){
        title = "Your Score: \(score)/10"
    }
    private func chooseThreeRandomCountries(){
        countries.shuffle()
        var index = 0
        for button in buttons{
            let name = countries[index]
            button.setImage(UIImage(named: name), for: .normal)
            index += 1
        }
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        let title = processAnswer(actualAnswer: sender.tag)
        // show alerts
        if currentQuestionCount <= maxQuestionCount {
            var msg = ["Good job! :)", "Fabulous! :)", "Amazing! :)"]
            if title == "Wrong"{
                msg = ["You guessed \(countries[sender.tag]) :("]
            }
            showAlert(title: title, message:  msg.randomElement()!  )
        }
//        if currentQuestionCount == maxQuestionCount {
//            let title = "Game Over"
//            showFinalAlert(title: title)
//        }
    }
    private func processAnswer(actualAnswer:Int)->String{
        score = actualAnswer == correctAnswer ? score + 1: score - 1
        let title = actualAnswer == correctAnswer ? "Correct": "Wrong"
        highlightRightFlag()
        if title == "Wrong"{
            highlightBadFlag(actualAnswer: actualAnswer)
        }
        return title
    }
    
    private func showAlert(title:String, message: String = "Good job!"){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if currentQuestionCount < maxQuestionCount{
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        }
        else{
            alertController.addAction(UIAlertAction(title: "Quit", style: .default, handler: quit))
        }
        present(alertController, animated: true)
    }
    
    private func highlightBadFlag(actualAnswer:Int){
        buttons[actualAnswer].layer.borderColor = UIColor.red.cgColor
        buttons[actualAnswer].alpha = 1
        buttons[actualAnswer].layer.borderWidth = 5
        
    }
    private func highlightRightFlag(){
        buttons[correctAnswer].layer.borderColor = UIColor.green.cgColor
        buttons[correctAnswer].alpha = 1
        buttons[correctAnswer].layer.borderWidth = 5
    }
    
    private func quit(action: UIAlertAction! = nil){
        exit(0)
    }
    private func showFinalAlert(title:String){
        let alertController = UIAlertController(title: title, message: "Your final score is \(score)/10", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Quit", style: .default, handler: quit))
        
        present(alertController, animated: true)
        
    }
    
    private func updateProgress(){
        let percentage = calcPercentageQuestionsLeft()
        updateProgressBar(percentage: percentage)
        updateProgressText(percentage: percentage)
    }
    private func resetProgressBar(){
        progressBar.progress = 1.0
    }
    
    private func updateProgressBar(percentage: Float){
        progressBar.progress = percentage
    }
    private func updateProgressText(percentage: Float){
        progressText.text = "\(Int(round(percentage*100.00) ))%"
    }
    
    private func calcPercentageQuestionsLeft()->Float{
        let difference = Float(maxQuestionCount - currentQuestionCount)
        let percent:Float = difference/Float(maxQuestionCount)
        return 1.0 - percent
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

