//
//  takingQuizController.swift
//  esteeLauderChallenge
//
//  Created by Alex Markova on 7/20/22.
//

import UIKit

class takingQuizController: UIViewController {
    var questionIndex = 0
    var percentProgress = 0.25
    var questionsArray: [String]
    var answersArray = [[""]]
    let amMatch = [
        "Do you want to retain your skin's firmness, reduce the appearance of fine lines and wrinkles, or boost the radiance of your skin?": ["YES!", "I suppose", "No"],
        "Do you want the best, most advanced anti-aging products on the market?": ["Definitely!", "I just want something that works.", "Not really."],
        "Are you struggling with your pores, skin discoloration, or an uneven skin tone?": ["Unfortunately", "No, but I want to prevent that", "Not at all"],
        "Last Question: How old are you?": [">25", "25 - 35", "35<"]]
    let findProduct = [
        "What are you looking for?": ["Foundation", "Anti-aging serum", "Revitalizing moisturizer"],
        "What do you want out the most?": ["Smooth skin", "Radiant skin", "Firm skin"],
        "Choose the second-most thing you want:": ["Flawless skin", "Youthful skin", "Hydrated skin"],
        "What are you most worried about?": ["Price", "Effectiveness", "Longitivity"]]
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var seeResultsButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let buttonClicked = UserDefaults.standard.object(forKey: "buttonClicked") as? String {
            if buttonClicked == "amMatch" {
                questionsArray = Array(amMatch.keys)
                answersArray = Array(amMatch.values)
            } else {
                questionsArray = Array(findProduct.keys)
                answersArray = Array(findProduct.values)
            }
        }
        progressBar.progress = 0.0
        questionLabel.text = questionsArray[0]
        answer1.setTitle(answersArray[0][0], for: .normal)
        answer2.setTitle(answersArray[0][1], for: .normal)
        answer3.setTitle(answersArray[0][2], for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    func updateScreen() {
        percentProgress+=0.25
        questionIndex += 1
        progressBar.setProgress(Float(percentProgress), animated: true)

        questionLabel.text = questionsArray[questionIndex]
        answer1.setTitle(answersArray[questionIndex][0], for: .normal)
        answer2.setTitle(answersArray[questionIndex][1], for: .normal)
        answer3.setTitle(answersArray[questionIndex][2], for: .normal)
    }
    @IBAction func answer1Clicked(_ sender: Any) {
        updateScreen()
    }
    @IBAction func answer2Clicked(_ sender: Any) {
        updateScreen()
    }
    @IBAction func answer3Clicked(_ sender: Any) {
        updateScreen()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
