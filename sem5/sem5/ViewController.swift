//
//  ViewController.swift
//  sem5
//
//  Created by Анастасия Коломникова on 03.10.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    public var text: String = "" {
        didSet{
            label.text = text
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func unwindToOne(_ sender: UIStoryboardSegue) {
        
    }
}

