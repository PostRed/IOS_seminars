import UIKit

class ViewController: UIViewController {

    var button = CustomButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: view.center.x - 100, y: view.center.y - 100, width: 200, height: 200)
        button = CustomButton(frame: frame)
        button.action = animation
        constrain.constant = -1000
        view.addSubview(button)
    }
    
    func animation() {
        UIView.animate(withDuration: 4,
         delay: 2,
         animations: {
            self.constrain.constant = 20
            self.view.layoutIfNeeded()
         })
    }
    @IBOutlet weak var constrain: NSLayoutConstraint!
    
    
    
}

