


import UIKit

class FirstViewController: UIViewController, TabBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didSelectTab(tabBarController: TabBarController) {
        print("first!")
    }
    @IBOutlet weak var age: UIView!
    @IBOutlet weak var age2: UIView!
    @IBOutlet weak var age3: UIView!
}
