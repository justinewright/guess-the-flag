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
    private lazy var quizBrain = QuizBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyleToButtons()
        updateUI()
    }

    private func applyStyleToButtons() {
        buttons.forEach{button in
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.cornerRadius = 5
            button.tintColor = UIColor.white
            button.layer.masksToBounds = true
        }
    }
    
    private func allDeselect() {
        buttons.forEach{button in
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.borderWidth = 1
            button.alpha = 0.75
        }
    }
    
    private func updateUI() {
        setScoreText()
        allDeselect()
        updateProgressBar()
        setButtonImages()
        setCorrectCountryText()
    }
    
    private func askQuestion(action: UIAlertAction! = nil) -> Void {
        quizBrain.nextQuestion()
        updateUI()
    }
    
    private func setCorrectCountryText() {
        countryText.text = "\(quizBrain.correctAnswerText)"
    }
    
    private func setScoreText(){
        title = "Your Score: \(quizBrain.score)/10"
    }
    
    private func setButtonImages() {
        var index = 0
        for button in buttons{
            let name = quizBrain.getCountryAtIndex(index: index)
            button.setImage(UIImage(named: name), for: .normal)
            index += 1
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let correctAnswer = quizBrain.checkAnswer(answer: sender.tag)
        highlightFlag(at: quizBrain.correctAnswerIndex, withColour: UIColor.green)
        if correctAnswer {
            makeRightAnswerAlert()
        }
        else{
            highlightFlag(at: sender.tag, withColour: UIColor.red)
            makeWrongAnswerAlert(userAnswer: sender.tag)
        }
    }
    
    private func makeRightAnswerAlert() {
        let title = "Correct"
        let msg = ["Good job! 😇", "Fabulous! 🥸", "Amazing! 😎"].randomElement()!
        showAlert(title: title, message:  msg)
    }
    
    private func makeWrongAnswerAlert(userAnswer: Int) {
        let title = "Wrong"
        let msg = "You guessed \(quizBrain.getCountryAtIndex(index: userAnswer)) 🥺"
        showAlert(title: title, message:  msg)
    }
 
    private func showAlert(title: String, message: String) {
        guard quizBrain.isGameRunning else {
            showQuestionFeedbackAlert2(title: title, message: message, actionTitle: "Restart", handler: restart)
            maxProgressBar()
            return
        }
        showQuestionFeedbackAlert2(title: title, message: message, actionTitle: "Continue", handler: askQuestion)
    }
    
    private func showQuestionFeedbackAlert2(title: String, message: String, actionTitle: String, handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        present(alertController, animated: true)
    }
    
    private func highlightFlag(at index: Int, withColour color: UIColor) {
        buttons[index].layer.borderColor = color.cgColor
        buttons[index].alpha = 1
        buttons[index].layer.borderWidth = 5
    }
    
    private func restart(action: UIAlertAction! = nil) {
        quizBrain.reset()
        updateUI()
    }

    private func updateProgressBar() {
        let percentage = quizBrain.progress
        progressBar.progress = percentage
        progressText.text = "\(Int( round(percentage*100.00) ))%"
    }
    
    private func maxProgressBar(){
        progressBar.progress = 1
        progressText.text = "\(100)%"
    }
}

