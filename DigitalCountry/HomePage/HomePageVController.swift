
import UIKit
import RxSwift
import RxCocoa


class HomePageVController: BaseVController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initsubViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    func initsubViews(){
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    }
}

extension Int{
    var square : Int {
        return self * self
    }
    var plus : Int {
        return self + self
    }
    
}
