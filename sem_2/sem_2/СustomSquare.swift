//
//  СustomSquare.swift
//  sem_2
//
//  Created by Анастасия Коломникова on 18.09.2023.
//

import Foundation
import UIKit

class СustomSquare: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setUpView() {
        backgroundColor = .red
    }
    
}
