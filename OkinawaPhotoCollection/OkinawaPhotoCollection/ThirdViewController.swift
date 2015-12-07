

import UIKit

class ThirdViewController: UIViewController, TabBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didSelectTab(tabBarController: TabBarController) {
        print("third!")
    }
}
