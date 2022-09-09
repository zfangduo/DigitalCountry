//
//  UIApplicationExt.swift
//  DigitalCountry
//
//  Created by 倪尛 on 2022/9/9.
//

import Foundation
import UIKit

extension UIApplication {
    var statusBarView: UIView?{
        if responds(to: Selector(("statusBar"))){
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
