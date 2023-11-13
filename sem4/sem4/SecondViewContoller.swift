//
//  SecondViewContoller.swift
//  sem4
//
//  Created by Анастасия Коломникова on 10.10.2023.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        loadImages()
        setupScrollView()
        setupImageViews()
    }
    
    private let scrollView = UIScrollView()
    
    private var images: [UIImage] = []

    private func setupScrollView() {
        scrollView.frame = view.bounds
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height:  (scrollView.bounds.height * 0.5 + 16) * 10)

                    
    }
    
    
    private func setupImageViews() {
        var previousImageView: UIImageView?
        
        for image in images {
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(imageView)
            
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            
            if let previousImageView = previousImageView {
                imageView.topAnchor.constraint(equalTo: previousImageView.bottomAnchor, constant: 16).isActive = true
            } else {
                imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
            }
            
            imageView.widthAnchor.constraint(equalToConstant: scrollView.bounds.width).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: scrollView.bounds.height * 0.5).isActive = true
            
            previousImageView = imageView
        }
    }

    
    private func loadImages() {
        let imageNames = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10"]
        for imageName in imageNames {
            if let image = UIImage(named: imageName) {
                images.append(image)
            }
        }
    }

}
