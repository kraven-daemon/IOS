//
//  ViewController.swift
//  OpenQuizz
//
//  Created by kev on 2023-02-19.
//

import UIKit

class ViewController: UIViewController {

    var game = Game()
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionView: QuestionView!
    
    @IBAction func didTapNewGame(_ sender: Any) {
        startNewGame()
    }
    private func startNewGame() {
        activityIndicator.isHidden = false
        newGameButton.isHidden = true
        
        questionView.title = "Loading..."
        questionView.style = .standard
        
        scoreLabel.text = "0 / 10"
        
        game.refresh()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = Notification.Name(rawValue: "QuestionsLoaded")
        NotificationCenter.default.addObserver(self, selector: #selector(questionLoaded), name: name, object: nil)
        startNewGame()
        
        // target, action, view
        let panGestureReconizer = UIPanGestureRecognizer(target: self, action: #selector(dragQuestionView))
        questionView.addGestureRecognizer(panGestureReconizer)
        
    }
    
    @objc func questionLoaded(){
        activityIndicator.isHidden = true
        newGameButton.isHidden = false
        questionView.title = game.currentQuestion.title
    }
    @objc func dragQuestionView(_ sender: UIPanGestureRecognizer ){
            if game.state == .ongoing{
                switch sender.state {
                case .began, .changed:
                    transforQuestionViewWith(gesture: sender)
                case .cancelled, .ended:
                    answerQuestion()
                default:
                    break
                }
        }
    }
    private func transforQuestionViewWith(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: questionView)
        let transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        let screenWidth = UIScreen.main.bounds.width
        
        let rotation = CGAffineTransform(rotationAngle: sin(translation.x/screenWidth/2))
        
        questionView.transform = transform.concatenating(rotation)
        if(translation.x > 0){
            questionView.style = .correct
        }else {
            questionView.style = .incorrect
        }
    }
    private func answerQuestion() {
        switch questionView.style {
        case .correct:
            game.answerCurrentQuestion(with: true)
        case .incorrect:
            game.answerCurrentQuestion(with: false)
        case .standard:
            break
        }
        scoreLabel.text = "\(game.score) / 10"
        //reset
        questionView.transform = .identity
        questionView.style = .standard
        questionView.title = game.currentQuestion.title
        
        switch game.state {
        case .ongoing:
            questionView.title = game.currentQuestion.title
        case .over:
            questionView.title = "Game Over"
        }
        
    }
    
}

