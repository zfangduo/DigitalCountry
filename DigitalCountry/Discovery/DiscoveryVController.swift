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
    var loadMore: LoadMoreControl?
    
    let uid:String = "97795069353"
    var user:User?
    
    var workAwemes = [Aweme]()
    
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
        
        loadMore = LoadMoreControl.init(frame: CGRect.init(x: 0, y: USER_INFO_HEADER_HEIGHT + SLIDE_TABBAR_FOOTER_HEIGHT, width: screenWidth, height: 50), surplusCount: 15)
        loadMore?.startLoading()
        loadMore?.onLoad = {[weak self] in
            self?.loadData(page: self?.pageIndex ?? 0)
        }
        collectionView?.addSubview(loadMore!)
    }
    
    func loadUserData() {
//        UserRequest.findUser(uid: uid, success: {[weak self] data in
//            self?.user = data as? User
//            self?.setNavigationBarTitle(title: self?.user?.nickname ?? "")
//            self?.collectionView?.reloadSections(IndexSet.init(integer: 0))
//        }, failure: { error in
//            UIWindow.showTips(text: error.localizedDescription)
//        })
    }
    
    func loadData(page: Int, _ size:Int = 21){
        if sliderTabIndex == 0 {
            AwemeListRequest.findPostAwemesPaged(uid: uid, page: page, size, success: {[weak self] data in
                if let response = data as? AwemeListResponse {
                    if self?.sliderTabIndex != 0 {
                        return
                    }
                    let array = response.data
                    self?.pageIndex += 1
                    
                    UIView.setAnimationsEnabled(false)
                    self?.collectionView?.performBatchUpdates({
                        self?.workAwemes += array
                        var indexPaths = [IndexPath]()
                        for row in ((self?.workAwemes.count ?? 0) - array.count)..<(self?.workAwemes.count ?? 0) {
                            indexPaths.append(IndexPath.init(row: row, section: 1))
                        }
                        self?.collectionView?.insertItems(at: indexPaths)
                    }, completion: { finished in
                        UIView.setAnimationsEnabled(true)
                        self?.loadMore?.endLoading()
                        if response.has_more == 0 {
                            self?.loadMore?.loadingAll()
                        }
                    })
                }
            }, failure:{ error in
                self.loadMore?.loadingFailed()
            })
        }
    }
    @objc func onNetworkStatusChange(notification: NSNotification){
        if !NetworkManager.isNotReachableStatus(status: NetworkManager.networkStatus()) {
            if user == nil {
                loadUserData()
            }
//            if favoriteAwemes.count == 0 && workAwemes.count == 0 {
//                loadData(page: pageIndex)
//            }
        }
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
                
                self.loadMore?.reset()
                self.loadMore?.startLoading()
                
                self.loadData(page: self.pageIndex)
            }

        }
    }
}
