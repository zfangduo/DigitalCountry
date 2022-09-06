//
//  BaseNavigationController.swift
//  DigitalCountry
//
//  Created by 倪尛 on 2022/9/6.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = .Background
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        setNavigationBarHidden(true, animated: false)
        
    }

}
