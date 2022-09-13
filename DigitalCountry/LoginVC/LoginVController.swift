//
//  LoginVController.swift
//  DigitalCountry
//
//  Created by 倪尛 on 2022/9/13.
//

import UIKit

class LoginVController: BaseVController {
    
    var collectionView:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavgationBarTitleColor(color: ColorClear)
        self.setNavigationBarBackgroundColor(color: ColorClear)
        self.setStatusBarBackgroundColor(color: ColorClear)
        self.setStatusBarStyle(style: .lightContent)
        self.setStatusBarHidden(hidden: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNetworkStatusChange(notification:)), name: Notification.Name(rawValue: NetworkStatesChangeNotification), object: nil)
        
    }
    
    @objc func onNetworkStatusChange(notification: NSNotification){
        
    }

    

}
