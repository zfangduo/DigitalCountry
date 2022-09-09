//
//  MineInfoVController.swift
//  DigitalCountry
//
//  Created by 倪尛 on 2022/9/6.
//

import UIKit
import RxSwift
import SnapKit
class MineInfoVController: BaseVController {

    // MARK: - UI Component
    var collectionView : UICollectionView!
    var profileBackgroundImage : UIImageView!
    var profileHeaderView : ProfileHeaderView?
    
    // MARK: - Variables
    let CELLID = "ProfileCell"
    let PROFILE_HEADER_ID = "ProfileHeader"
    let SLIDEBAR_ID = "ProfileSlideBar"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews();
    }
    func setupViews(){
        self.view.backgroundColor = .Background
        let collectionViewFlowLayout = ProfileCollectionViewFlowLayout(navBarHeight: getStatusBarheight())
        collectionViewFlowLayout.minimumLineSpacing = 1
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false  //是否自动生成约束
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .never          //滚动指示器是都自动调整
        collectionView.alwaysBounceVertical = true
        collectionView.alwaysBounceHorizontal = false
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.register(UINib(nibName: "ProfileHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PROFILE_HEADER_ID)
        collectionView.register(ProfileSlideBarView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: SLIDEBAR_ID)
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: CELLID)
        collectionView.layoutIfNeeded()
        
        //backgroundImageview
        profileBackgroundImage = UIImageView(image: #imageLiteral(resourceName: "mineHeader"))
        profileBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        profileBackgroundImage.contentMode = .scaleAspectFill
        profileBackgroundImage.alpha = 0.6
        self.view.insertSubview(profileBackgroundImage, belowSubview: collectionView)
        profileBackgroundImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(150)
        }
        
    }
}
extension MineInfoVController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return 20
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELLID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            if kind == UICollectionView.elementKindSectionHeader {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PROFILE_HEADER_ID, for: indexPath) as! ProfileHeaderView
                profileHeaderView = headerView
                return headerView
            }
        }
        
        if indexPath.section == 1 {
            if kind == UICollectionView.elementKindSectionHeader {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SLIDEBAR_ID, for: indexPath) as! ProfileSlideBarView
                return headerView
            }
        }
        return UICollectionReusableView.init()
    }
    
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize.init(width: ScreenSize.width, height: 420)
        case 1:
            return CGSize.init(width: ScreenSize.width, height: 42)
        default:
            return .zero
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (ScreenSize.width - CGFloat(Int(ScreenSize.width) % 3)) / 3.0 - 1.0
        let itemHeight = itemWidth * 1.3
        return CGSize.init(width: itemWidth, height: itemHeight)
    }
}
extension MineInfoVController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            stretchMinebackgroundWhenScroll(offsetY: offsetY)
        }else{
            profileBackgroundImage.transform = CGAffineTransform(translationX: 0, y: -offsetY)
        }
    }
    
    func stretchMinebackgroundWhenScroll(offsetY: CGFloat) {
        let scaleRatio: CGFloat = abs(offsetY)/500.0
        let scaleHeight: CGFloat = scaleRatio * profileBackgroundImage.frame.height
        profileBackgroundImage.transform = CGAffineTransform.init(translationX: 0, y: scaleHeight)
    }
}
