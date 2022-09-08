//
//  UIViewControllerExt.swift
//  DigitalCountry
//
//  Created by 倪尛 on 2022/9/7.
//

import Foundation
import UIKit

extension UIViewController{
    func getStatusBarheight() -> CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
}
