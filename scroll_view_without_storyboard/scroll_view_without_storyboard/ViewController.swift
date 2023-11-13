//
//  ViewController.swift
//  scroll_view_without_storyboard
//
//  Created by Анастасия Коломникова on 10.10.2023.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    let borderH: CGFloat = 20.0
    var sumH: CGFloat = 0.0
    let sv: UIScrollView! = UIScrollView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupScrollView()
        createContents()
    }
    
    private func setupScrollView() {
        sv.delegate = self
        sv.isScrollEnabled = true
        sv.isPagingEnabled = false
        sv.showsVerticalScrollIndicator = true
        sv.backgroundColor = UIColor.gray
        self.view.addSubview(sv)
    }
    
    private func createImagePage(size: CGSize, imageName: String, radius: CGFloat = 20) -> UIView {
        let aFrame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let aPage = UIImageView(frame: aFrame)
        aPage.image = UIImage(named: imageName)
        aPage.translatesAutoresizingMaskIntoConstraints = true
        aPage.layer.cornerRadius = radius + 30
        aPage.layer.masksToBounds = false
        return aPage
    }
    
    private func createContents() {
        var cnt = 0
        
        cnt = 5
        for _ in 0..<cnt {
            let h:  CGFloat = UIScreen.main.bounds.width
            let size = CGSize(width: h, height: h)
            let page = createImagePage(size: size, imageName: "image1")
            page.frame.origin.y = sumH
            sv.addSubview(page)
            sumH += h + borderH
        }
        
        cnt = 2
        for i in 0..<cnt {
            let h: CGFloat = UIScreen.main.bounds.width / 4
            let size = CGSize(width: UIScreen.main.bounds.width, height: h)
            let page = createLabelPage(size: size, text: "tuesday 10.10", tag: i + 1)
            page.frame.origin.y = sumH
            sv.addSubview(page)
            sumH += h + borderH
        }
        
        sv.contentSize = CGSize(width: UIScreen.main.bounds.width, height: sumH - borderH)
    }
    
    func createLabelPage(size:CGSize, text: String, radius: CGFloat = 20, tag: Int = -1) -> UIView {
        let aFrame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let aLabel = UILabel(frame: aFrame)
        aLabel.lineBreakMode = .byWordWrapping
        aLabel.numberOfLines = 0
        aLabel.translatesAutoresizingMaskIntoConstraints = true
        
        aLabel.layer.cornerRadius = radius
        aLabel.layer.masksToBounds = true
        aLabel.backgroundColor = .systemBlue
        aLabel.tag = (tag >= 0) ? tag : aLabel.tag
        aLabel.text = text
        return aLabel
    }
//    
//    func createMyCellPage(size: CGSize, radius: CGFloat = 20, index: Int = -1) -> UIView {
//        let aFrame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        let aPage = UIImageView(MyCell)
//        
//    }
}
