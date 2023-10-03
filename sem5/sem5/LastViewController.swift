//
//  LastViewController.swift
//  sem5
//
//  Created by Анастасия Коломникова on 03.10.2023.
//

import UIKit

class LastViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ViewController
        else {
            return
        }
        vc.label.text = "new TEXT"
    }
    

}
