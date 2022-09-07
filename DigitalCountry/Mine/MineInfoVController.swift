//
//  MineInfoVController.swift
//  DigitalCountry
//
//  Created by 倪尛 on 2022/9/6.
//

import UIKit
import RxSwift

class MineInfoVController: BaseVController {

    // MARK: - UI Component
    var collectionView : UICollectionView!
    var profileBackgroundImage : UIImageView!
    var profileHeaderView : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews();
    }
    func setupViews(){
        self.view.backgroundColor = .Background
        
    }
}
