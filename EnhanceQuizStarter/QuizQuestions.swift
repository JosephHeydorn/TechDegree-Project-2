//
//  QuizQuestions.swift
//  EnhanceQuizStarter
//
//  Created by Joseph Heydorn on 3/19/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import GameKit
//Preparing for the class set up
struct QuestionSetUp {
    let question: String
    let options: [String]
    let correctAnswer: Int
}
//Creating the list of different questions using a class, make it easier to add questions as well.
class Questions {
    var indexOfSelectedQuestion = 0
    var questionNonRepeat = 0
    let setOfQuestions = [
        QuestionSetUp(question: "This was the only US President to serve more than two consecutive terms.", options: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson","Andrew Jackson"], correctAnswer: 1),
        QuestionSetUp(question: "Which of the following countries has the most residents?", options: ["Nigeria","Russia","Iran","Vietnam"], correctAnswer: 0),
        QuestionSetUp(question: "In what year was the United Nations founded?", options: ["1918","1919","1945","1954"], correctAnswer: 2),
        QuestionSetUp(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", options: ["Paris","Washington D.C.","New York City","Boston"], correctAnswer: 2),
        QuestionSetUp(question: "Which nation produces the most oil?", options: ["Iran","Iraq","Brazil","Canada"], correctAnswer: 3),
        QuestionSetUp(question: "Which country has most recently won consecutive World Cups in Soccer?", options: ["Italy","Brazil","Argentina","Spain"], correctAnswer: 2),
        QuestionSetUp(question: "Which of the following rivers is the longest?", options: ["Yangtze","Mississippi","Congo","Mekong"], correctAnswer: 1),
        QuestionSetUp(question: "Which city is the oldest?", options: ["Mexico City","Cape Town","San Juan", "Sydney"], correctAnswer: 0),
        QuestionSetUp(question: "Which country was the first to allow women to vote in national elections?", options: ["Poland", "United States", "Sweden", "Senegal"], correctAnswer: 0),
        QuestionSetUp(question: "Which of these countries won the most medals in the 2012 Summer Games?", options: ["France","Germany","Japan","Great Britan"], correctAnswer: 3)
    ]
    //Function for generating a random nonrepeating question with all 4 answer choices
    func randomQuestion() -> String {
        let questionNonRepeat = indexOfSelectedQuestion
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: setOfQuestions.count)
        //Double Checks to make sure no repeat is possible
        if questionNonRepeat == indexOfSelectedQuestion {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: setOfQuestions.count)
            if questionNonRepeat == indexOfSelectedQuestion {
                indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: setOfQuestions.count)
            }
        }
        let questionPicker = setOfQuestions[indexOfSelectedQuestion]
        let finalQuestion = questionPicker.question
        return finalQuestion
    }
    
    func determiningAnswer1() -> String {
        let answer1 = setOfQuestions[indexOfSelectedQuestion]
        let finalanswer1 = answer1.options[0]
        return finalanswer1
    }
    func determiningAnswer2() -> String {
        let answer2 = setOfQuestions[indexOfSelectedQuestion]
        let finalanswer2 = answer2.options[1]
        return finalanswer2
    }
    func determiningAnswer3() -> String {
        let answer3 = setOfQuestions[indexOfSelectedQuestion]
        let finalanswer3 = answer3.options[2]
        return finalanswer3
    }
    func determiningAnswer4() -> String {
        let answer4 = setOfQuestions[indexOfSelectedQuestion]
        let finalanswer4 = answer4.options[3]
        return finalanswer4
    }
    func checkCorrectAnswer() -> Int {
        let correctAnswers = setOfQuestions[indexOfSelectedQuestion]
        let answerInt = correctAnswers.correctAnswer
        return answerInt
    }
    
}



















