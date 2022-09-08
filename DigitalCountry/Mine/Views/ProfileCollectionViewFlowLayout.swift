//
//  ProfileCollectionViewFlowLayout.swift
//  DigitalCountry
//
//  Created by 倪尛 on 2022/9/7.
//

import UIKit

class ProfileCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var navBarHeight : CGFloat = 0
    init(navBarHeight: CGFloat) {
        super.init()
        self.navBarHeight = navBarHeight
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
