//
//  TakeQuizOptions.swift
//  esteeLauderChallenge
//
//  Created by Alex Markova on 7/19/22.
//

import UIKit

class TakeQuizOptionsController
: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func amMatchClicked(_ sender: Any) {
        let buttonClicked = "AmMatch"
        UserDefaults.standard.set(buttonClicked, forKey: "buttonClicked")
    }
    
    @IBAction func whichProductClicked(_ sender: Any) {
        let buttonClicked = "findProduct"
        UserDefaults.standard.set(buttonClicked, forKey: "buttonClicked")
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
