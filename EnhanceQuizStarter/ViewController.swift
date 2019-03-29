//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    //Creating variables for each sound
    var gameSound: SystemSoundID = 0
    var gameSound1: SystemSoundID = 0
    var gameSound2: SystemSoundID = 0
    var gameSound3: SystemSoundID = 0
    
    let questionProvidor = Questions()
    // MARK: - Outlets
    //Ganerates each of the buttons
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    @IBOutlet weak var rightOrWrong: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameSounds()
        playGameStartSound()
        displayQuestion()
    }
    
    // MARK: - Helpers
    //Loading in all the sound
    func loadGameSounds() {
        //Start Game Sound
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
        //Correct Game Sound
        let path1 = Bundle.main.path(forResource: "Unit2Correct", ofType: "wav")
        let soundUrl1 = URL(fileURLWithPath: path1!)
        AudioServicesCreateSystemSoundID(soundUrl1 as CFURL, &gameSound1)
        //Wrong Game Sound
        let path2 = Bundle.main.path(forResource: "Unit2Wrong", ofType: "wav")
        let soundUrl2 = URL(fileURLWithPath: path2!)
        AudioServicesCreateSystemSoundID(soundUrl2 as CFURL, &gameSound2)
        //Play Again Game Sound
        let path3 = Bundle.main.path(forResource: "Unit2PlayAgainSounds", ofType: "wav")
        let soundUrl3 = URL(fileURLWithPath: path3!)
        AudioServicesCreateSystemSoundID(soundUrl3 as CFURL, &gameSound3)
        
    }
    //Individual function for each sound
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    func playGameCorrectSound() {
        AudioServicesPlaySystemSound(gameSound1)
    }
    func playGameWrongSound() {
        AudioServicesPlaySystemSound(gameSound2)
    }
    func playGameAgainSound() {
        AudioServicesPlaySystemSound(gameSound3)
    }
    //Displays the question from the QuizQuestions swift file on the StoryBoard
    func displayQuestion() {
        questionField.text = questionProvidor.randomQuestion()
        answer1.setTitle(questionProvidor.determiningAnswer1(), for: .normal)
        answer2.setTitle(questionProvidor.determiningAnswer2(), for: .normal)
        answer3.setTitle(questionProvidor.determiningAnswer3(), for: .normal)
        answer4.setTitle(questionProvidor.determiningAnswer4(), for: .normal)
        playAgainButton.isHidden = true
        rightOrWrong.isHidden = true
        answer1.isHidden = false
        answer2.isHidden = false
        answer3.isHidden = false
        answer4.isHidden = false
    }
    //Displays game score after 4 questions with option to play again
    func displayScore() {
        // Hide the answer uttons
        answer1.isHidden = true
        answer2.isHidden = true
        answer3.isHidden = true
        answer4.isHidden = true
        rightOrWrong.isHidden = true
        questionField.isHidden = false
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    //Generates the next round or determines if all 4 rounds are completed
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
            questionField.isHidden = false
        }
    }
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    // MARK: - Actions
   //Analyzes the question and the option for each question to see if the user chose the correct option
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        rightOrWrong.isHidden = false
        questionField.isHidden = true

        questionsAsked += 1

        let correctAnswer = questionProvidor.checkCorrectAnswer()
        
        if (sender === answer1 &&  correctAnswer == 0) || (sender === answer2 && correctAnswer == 1) || (sender === answer3 && correctAnswer == 2) || (sender === answer4 && correctAnswer == 3){
            correctQuestions += 1
            rightOrWrong.text = "Correct!"
            answer1.isHidden = true
            answer2.isHidden = true
            answer3.isHidden = true
            answer4.isHidden = true
            playGameCorrectSound()
        } else {
            rightOrWrong.text = "Sorry, wrong answer!"
            answer1.isHidden = true
            answer2.isHidden = true
            answer3.isHidden = true
            answer4.isHidden = true
            playGameWrongSound()
        }
        
        loadNextRound(delay: 2)
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        answer1.isHidden = false
        answer2.isHidden = false
        answer3.isHidden = false
        answer4.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        playGameAgainSound()
        nextRound()
    }
    

}


