//
//  ViewController.swift
//  sem8_
//
//  Created by Анастасия Коломникова on 07.11.2023.
//

import UIKit

class Model {
    var users: [User_] = []
}

class ViewController: UIViewController {
    let model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user1 = createRandomUser()
        let user2 = createRandomUser()
        addUser(user: user1, model: model)
        addUser(user: user2, model: model)
        let label1 = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 30))
        label1.text = "User1 Info: \(user1.name) \(user1.id)"
        view.addSubview(label1)
        let label2 = UILabel(frame: CGRect(x: 50, y: 150, width: 200, height: 30))
        label2.text = "User2 Info: \(user2.name) \(user2.id)"
        view.addSubview(label2)

    }
    

    func createRandomUser() -> User_ {
        let id = Int.random(in: 1...100)
        let names = ["Настя", "Миша", "Федя", "Антон", "Леня"]
        let randomName = names.randomElement()!
        return User_(id: id, name: randomName)
    }
    
    func addUser(user: User_, model: Model) {
        model.users.append(user)
    }
}

