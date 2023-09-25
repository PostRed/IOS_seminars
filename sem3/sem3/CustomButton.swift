import Foundation
import UIKit

class CustomButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.myInit()
    }
    
   
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func myInit() {
        self.backgroundColor = .blue
        self.layer.cornerRadius = self.frame.size.width / 2
        self.setTitle("Press to start", for: UIControl.State.normal)
        self.addTarget(self, action: #selector(animation), for: .touchUpInside)
    }
    
    var action: (() -> ())?
    
    @objc private func animation() {
        action!()
        UIView.animate(withDuration: 2,
         delay: 0.2,
         animations: {
            let width = self.frame.size.width
            let height = self.frame.size.height
            self.frame.size = CGSizeMake(width + 20, height + 20)
            if self.backgroundColor == .blue {
                self.backgroundColor = .systemPink
            } else {
                self.backgroundColor = .blue
            }
        }) {_ in
            UIView.animate(withDuration: 2,
             delay: 0.3,
             animations: {
                let w = self.frame.size.width
                let h = self.frame.size.height
                self.frame.size = CGSizeMake(w - 20, h - 20)
                if self.backgroundColor == .blue {
                    self.backgroundColor = .systemPink
                } else {
                    self.backgroundColor = .blue 
                }
            })
                
        }

        
    }
}
