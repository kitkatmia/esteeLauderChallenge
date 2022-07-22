//
//  quizResultsController.swift
//  esteeLauderChallenge
//
//  Created by Alex Markova on 7/19/22.
//

import UIKit

class quizResultsController: UIViewController {
    var age = ""
    var possibleProductOutputs = [
        "foundation and serum": ["You’re a perfect fit for both our Double Wear Stay-in-Place Foundation and our Advanced Night Repair Serum. While the foundation will last in all types of weather on all types of skin tones and give you the smooth, unified complexion desired, the night repair serum will make your skin look and feel younger, less wrinkled, more radiant, and even toned. To buy these products or find out more, visit our website!", "11.jpg"],
        "foundation and moisturizer": ["You’re a perfect fit for both our Double Wear Stay-in-Place Foundation and our Revitalizing Supreme+ Moisturizer! While the foundation will last in all types of weather on all types of skin tones and give you the smooth, unified complexion desired, the moisturizer will supply a new-found layer of firmness, strenght, and radiance to your skin (not to mention a more lifted look). To buy these products or find out more, visit our website!", "8.jpg"],
        "moisturizer and serum": ["You’re a perfect fit for both our Revitalizing Supreme+ Moisturizer and our Advanced Night Repair Serum. These two products work in conjunction with both the moisturizer AND the night serum supplying a new-found layer of firmness, strength, and radiance to your skin (not to mention a more lifted and less wrinkled look). To buy these products or find out more, visit our website!", "10.jpg"],
        "foundation": ["You’re a perfect fit for our Double Wear Stay-in-Place Foundation! Award winner of the Allure Best of Beauty contest, this 24-hour liquid foundation lasts in all types of weather while retaining its lightweight, comfy feel. Estée’s full-coverage foundation is key to allow for a beautiful complexion on all skin tones (over 55 different shades available). To buy this product or find out more, visit our website!", "11.jpg"],
        "serum": ["You’re a perfect fit for our Advanced Night Repair Serum! Users found that this serum makes their skin look (and feel!) younger, hydrated, more radiant, and even toned. Proven effective on all skin tones, it is referred to as the #1 serum in the US*. To buy this product or find out more, visit our website!", "6.jpg"],
        "moisturizer":["You’re a perfect fit for our Revitalizing Supreme+ Moisturizer. Youth Power Cream! By harnessing the power of exclusive, natural extracts, Estée Lauder has created a moisturizer that provides it all: Firmness. Strength. Radiance. Not to mention the lifted look your skin will have and the silky, feel-good texture of the creme. To buy this product or find out more, visit our website!", "10.jpg"]]
    
    var possibleMatchOutputsOver35 = [
        "low match": ["Although you may not be the most enthusiastic about skin care focused on rejuvenation, we would still recommend you give our products a try! And if you’re still hesitant, take a look at our customer’s reviews – Estée’s the best on the market.", "4.jpg"],
        "great fit":["While skincare may not be your personality, you’re still a great fit for our products! Take our “Which one should I get?” to further narrow down which product is best for you.", "4.jpg"],
        "amazing fit":["You’re the perfect fit for our products; we have exactly what you need! Take our “Which one should I get?” to further narrow down which product is best for you.", "4.jpg"]]
    
var possibleMatchOutputsBetween35 = [
        "low match": ["Although you may not be the most enthusiastic about skin care focused on rejuvenation, we would still recommend you give our products a try! And if you’re still hesitant, take a look at our customer’s reviews – Estée’s the best on the market. Remember, you're never too young or too old to start taking care of your skin!", "4.jpg"],
        "great fit":["While skincare may not be your personality, you’re still a great fit for our products! Remember, you're never too young or too old to start taking care of your skin. Take our “Which one should I get?” to further narrow down which product is best for you.", "4.jpg"],
        "amazing fit":["You’re the perfect fit for our products; we have exactly what you need! Remember, you're never too young or too old to start taking care of your skin. Take our “Which one should I get?” to further narrow down which product is best for you.", "4.jpg"]]
var possibleMatchOutputsUnder25 = [
        "low match": ["Although you may not be the most enthusiastic about skin care focused on rejuvenation, we would still recommend you check out  products! Even if you aren't interested in them, your loved ones may be and appreaciate the present!", "4.jpg"],
        "great fit":["While skincare may not be your personality, you’re still a great fit for our products; our concealor is right up your alley! We're sure your loved ones would appreciate a gift from Estée’s as well.", "4.jpg"],
        "amazing fit":["You’re the perfect fit for our products; we have exactly what you need! Take our “Which one should I get?” to further narrow down which product is best for you.", "4.jpg"]]

    @IBOutlet weak var resultsImage: UIImageView!
    @IBOutlet weak var visitWebsiteButton: UIButton!
    @IBOutlet weak var textBelowImage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visitWebsiteButton.isHidden = true
        if let winner = UserDefaults.standard.object(forKey: "winner") as? String {
            if possibleProductOutputs.keys.contains(winner) {
                visitWebsiteButton.isHidden = false
                textBelowImage.text = possibleProductOutputs[winner]?[0]
                resultsImage.image = UIImage(named:(possibleProductOutputs[winner]?[1])!)
            } else if possibleMatchOutputsOver35.keys.contains(winner) {
                age = UserDefaults.standard.object(forKey: "age") as! String
                if age.contains("25") {
                    textBelowImage.text = possibleMatchOutputsUnder25[winner]?[0]
                    resultsImage.image = UIImage(named:possibleMatchOutputsUnder25[winner]![1])
                } else if age.contains("and") {
                    textBelowImage.text = possibleMatchOutputsBetween35[winner]?[0]
                    resultsImage.image = UIImage(named:possibleMatchOutputsBetween35[winner]![1])
                } else {
                    textBelowImage.text = possibleMatchOutputsOver35[winner]?[0]
                    resultsImage.image = UIImage(named:possibleMatchOutputsOver35[winner]![1])
                }

            } else {
                print("An error has ocurred")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToStartButton(_ sender: Any) {
    }
    @IBAction func visitWebsiteButton(_ sender: Any) {
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
