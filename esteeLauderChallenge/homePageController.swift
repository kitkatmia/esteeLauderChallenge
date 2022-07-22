//
//  homePage.swift
//  esteeLauderChallenge
//
//  Created by Alex Markova on 7/19/22.
//

import UIKit

class homePage: UIViewController {
    @IBOutlet weak var buyNowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buyNowButton(_ sender: Any) {
        if let url = URL (string: "https://www.esteelauder.com/") {
            UIApplication.shared.open (url)
        }
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
