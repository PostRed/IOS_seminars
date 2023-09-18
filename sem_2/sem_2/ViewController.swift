//
//  ViewController.swift
//  sem_2
//
//  Created by Анастасия Коломникова on 18.09.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var str: UILabel!
    
    @IBOutlet weak var generateNew: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let customSquare = СustomSquare()
        view.addSubview(customSquare)
        customSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customSquare.widthAnchor.constraint(equalToConstant: 80),
            customSquare.heightAnchor.constraint(equalToConstant: 80),
            customSquare.centerXAnchor.constraint(equalTo: myView.centerXAnchor),
            customSquare.centerYAnchor.constraint(equalTo: myView.centerYAnchor)
        ])
    }
    func randomString() -> String {

        let letters : NSString = "abcdefghijklmnopqrstuvwxyz"
        var res = ""
        for _ in 0 ..< 20 {
            let rand = arc4random_uniform(26)
            var nextChar = letters.character(at: Int(rand))
            res += NSString(characters: &nextChar, length: 1) as String
        }
        return res
    }
    
    @IBAction func changeText(_ sender: Any) {
        str.text = randomString()
    }
    
}

