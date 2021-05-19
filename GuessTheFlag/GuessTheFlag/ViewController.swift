//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Justine Wright on 2021/05/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var button1: UIButton!
    @IBOutlet private weak var button2: UIButton!
    @IBOutlet private weak var button3: UIButton!
    
    private lazy var countries = [String]() // lazy = delay instantiation until required
    private lazy var score = 0
    private lazy var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountries()
        applyStyleToButtons()
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
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        // UIColor (red:, green:, blue:).cgColour
        
    }
    // UIAlertAction needed for alertController
    private func askQuestion(action: UIAlertAction! = nil)->Void{
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        //for: .normal -> takes in parameter for state of button
        // .normal -> from a struct
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        score = sender.tag == correctAnswer ? score + 1: score - 1
        let title = sender.tag == correctAnswer ? "Correct": "Wrong"
        showAlert(title: title)
    }
    
    private func showAlert(title:String){
        let alertController = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(alertController, animated: true)

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
    // -show score in navigation bar
    // -keep track of how many questions have been asked
    // -max queestions 10
    // -10 -> final alert controller
    
    // 3 challenge
    // mistake
    // tell them what flag they selected, and what flag was right
}

