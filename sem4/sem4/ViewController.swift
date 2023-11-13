//
//  ViewController.swift
//  sem4
//
//  Created by Анастасия Коломникова on 10.10.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        goToSecondViewController()

    }

    func goToSecondViewController() {
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    


}

