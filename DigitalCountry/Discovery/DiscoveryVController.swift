//
//  DiscoveryVController.swift
//  DigitalCountry
//
//  Created by 倪尛 on 2022/9/6.
//

import UIKit


var USER_INFO_HEADER_HEIGHT:CGFloat = 340 + statusBarHeight
var SLIDE_TABBAR_FOOTER_HEIGHT:CGFloat = 40
// MARK: - Variables
let USER_INFO_HEADER:String = "UserInfoHeader"
let SLIDE_TABBAR_FOOTER:String = "SlideTabBarFooter"
let AWEME_COLLECTION_CELL:String = "AwemeCollectionCell"


class DiscoveryVController: BaseVController {
    var collectionView:UICollectionView!
    
    var pageIndex = 0;
    let pageSize = 21
    var sliderTabIndex = 0
    var itemWidth:CGFloat = 0
    var itemHeight:CGFloat = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavgationBarTitleColor(color: ColorClear)
        self.setNavigationBarBackgroundColor(color: ColorClear)
        self.setStatusBarStyle(style: .lightContent)
        self.setStatusBarHidden(hidden: false)

        NotificationCenter.default.addObserver(self, selector: #selector(onNetworkStatusChange(notification:)), name: Notification.Name(rawValue: NetworkStatesChangeNotification), object: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        itemWidth = (ScreenSize.width - CGFloat(Int(ScreenSize.width) % 3)) / 3.0 - 1.0
        itemHeight =  itemWidth * 1.3
        let layout = ProfileCollectionViewFlowLayout.init(navBarHeight: safeAreaTopHeight)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - safeAreaBottomHeight - 49), collectionViewLayout: layout)
        collectionView?.backgroundColor = ColorClear
        if #available(iOS 11.0, *){
            collectionView?.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        collectionView?.alwaysBounceVertical = true
        collectionView?.alwaysBounceHorizontal = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(UserInfoHeader.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: USER_INFO_HEADER)
        collectionView?.register(SlideTabBarFooter.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SLIDE_TABBAR_FOOTER)
        collectionView?.register(AwemeCollectionCell.classForCoder(), forCellWithReuseIdentifier: AWEME_COLLECTION_CELL)
        self.view.addSubview(collectionView!)
        
    }
    @objc func onNetworkStatusChange(notification: NSNotification){
        
    }

}

extension DiscoveryVController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return 9
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AWEME_COLLECTION_CELL, for: indexPath) as! AwemeCollectionCell
        cell.backgroundColor = .red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: USER_INFO_HEADER, for: indexPath) as! UserInfoHeader
                header.backgroundColor = .yellow
                return header
            }else{
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SLIDE_TABBAR_FOOTER, for: indexPath) as! SlideTabBarFooter
                footerView.delegate = self
                footerView.setLabel(titles: ["作品 10", "喜欢 8", "收藏"], tabIndex: sliderTabIndex)
                return footerView
            }
        }
        return UICollectionReusableView.init()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? CGSize.init(width: screenWidth, height: USER_INFO_HEADER_HEIGHT) : .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return section == 0 ? CGSize.init(width: screenWidth, height: SLIDE_TABBAR_FOOTER_HEIGHT) : .zero
    }
}
extension DiscoveryVController: OnTabTapActionDelegate {
    
    
    
    func onTapAction(index: Int) {
        if sliderTabIndex != index {
            sliderTabIndex = index
            pageIndex = 0
            UIView.setAnimationsEnabled(false)
            collectionView.performBatchUpdates {
                
            } completion: { finished in
                UIView.setAnimationsEnabled(true)
            }

        }
    }
}
