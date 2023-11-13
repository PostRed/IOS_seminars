//
//  CustomImageViewController.swift
//  sem4
//
//  Created by Анастасия Коломникова on 10.10.2023.
//

import Foundation

import UIKit

class CustomImageViewController: UIViewController {
    
    private let centeredImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
    }
    
    private func setupImageView() {
        view.backgroundColor = .systemBackground
        view.addSubview(centeredImageView)
        
        NSLayoutConstraint.activate([
            centeredImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centeredImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centeredImageView.widthAnchor.constraint(equalToConstant: 200),
            centeredImageView.heightAnchor.constraint(equalToConstant: 200)
        ])

        centeredImageView.image = UIImage(named: "image1")
    }
}

