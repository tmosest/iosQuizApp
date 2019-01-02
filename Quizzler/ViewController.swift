//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let questionBank = QuestionBank()
    var questionIndex = 0
    var score = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
      let value = (sender.tag == 1) ? true : false
      checkAnswer(value)
    }
    
    
    func updateUI() {
      let numberOfQuestions = questionBank.questions.count
      questionLabel.text = questionBank.questions[questionIndex].questionText
      progressLabel.text = "\(questionIndex + 1)/\(numberOfQuestions)"
      scoreLabel.text = "Score: \(score)"
      progressBar.frame.size.width = (view.frame.size.width / CGFloat(numberOfQuestions)) * CGFloat(questionIndex + 1)
    }
    

    func nextQuestion() {
      if (questionIndex + 1 < questionBank.questions.count) {
        questionIndex += 1
        updateUI()
      } else {
        let alert = UIAlertController(title: "Gameover!", message: "You've finished all the questions", preferredStyle: .alert)
        let alertActionHandler = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
          self.startOver()
        })
        alert.addAction(alertActionHandler)
        present(alert, animated: true, completion: nil)
      }
    }
    
    
    func checkAnswer(_ value: Bool) {
      if value == questionBank.questions[questionIndex].answer {
        score += 1
        ProgressHUD.showSuccess("Correct!")
      } else {
        ProgressHUD.showError("Wrong!")
      }
      nextQuestion()
    }
    
    
    func startOver() {
      questionIndex = 0
      score = 0
      updateUI()
    }
}
