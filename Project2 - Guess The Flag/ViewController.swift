//
//  ViewController.swift
//  Project2 - Guess The Flag
//
//  Created by Travis Brigman on 4/22/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    
    var correctAnswer = 0
    var score = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        askQuestion(action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(shareTapped))
        
    }
    
    func askQuestion(action: UIAlertAction!) {

        if questionsAsked < 10 {
            countries.shuffle()
            button1.setImage(UIImage(named: countries[0]), for: .normal)
            button2.setImage(UIImage(named: countries[1]), for: .normal)
            button3.setImage(UIImage(named: countries[2]), for: .normal)
            correctAnswer = Int.random(in: 0...2)
            let countryName = countries[correctAnswer].uppercased()
            title = "\(countryName) - \(score)"
            questionsAsked += 1
            
        } else {
            let ac = UIAlertController(title: "Complete", message: "you finished", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
            questionsAsked = 0
            correctAnswer = 0
            score = 0
        }
        
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String = ""
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: []) {
            sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { (finished) in
            sender.transform = .identity
        }

        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)"
        } else {
            title = "Incorrect"
            score -= 1
            message = "Wrong! That's the flag of \(countries[sender.tag])"
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    @objc func shareTapped() {

        let ac = UIAlertController(title: title, message: String(score), preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: .none))
        present(ac, animated: true)
    }
    
}

