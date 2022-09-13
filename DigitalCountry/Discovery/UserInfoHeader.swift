//
//  UserInfoHeader.swift
//  DigitalCountry
//
//  Created by 倪尛 on 2022/9/13.
//

import UIKit

protocol UserInfoDelegate: NSObjectProtocol {
    func onUserActionTap(tag: Int)
}

class UserInfoHeader: UICollectionReusableView {
    
    
    var delegate:UserInfoDelegate?
    
    var isFollowed:Bool = false
    
    var containerView: UIView!
    var avatarBackground: UIImageView = UIImageView.init()
    var avatar: UIImageView!
    var settingIcon: UIImageView!
    var focusIcon: UIImageView!
    var sendMessage: UILabel!
    var focusButton: UIButton!

    var nickName:UILabel = UILabel.init()
    var douyinNum:UILabel = UILabel.init()
    var github:UIButton = UIButton.init()
    var brief:UILabel = UILabel.init()
    var genderIcon:UIImageView = UIImageView.init(image: UIImage.init(named: "iconUserProfileGirl"))
    var constellation:UITextView = UITextView.init()
    var likeNum:UILabel = UILabel.init()
    var followNum:UILabel = UILabel.init()
    var followedNum:UILabel = UILabel.init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initAvatarBackGround()
        containerView = UIView.init(frame: self.bounds)
        self.addSubview(containerView)
        initAvatar()
        initActionsView()
        initInfoViews()
    }
    required init?(coder  aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initAvatarBackGround(){
        avatarBackground.frame = self.bounds
        avatarBackground.clipsToBounds = true
        avatarBackground.image = UIImage.init(named: "img_find_default")
        avatarBackground.backgroundColor = ColorThemeGray
        avatarBackground.contentMode = .scaleAspectFill
        self.addSubview(avatarBackground)
        
        let blurEffect = UIBlurEffect.init(style: UIBlurEffect.Style.dark)
        let visualEffectView = UIVisualEffectView.init(effect: blurEffect)
        visualEffectView.frame = self.bounds
        visualEffectView.alpha = 1
        avatarBackground.addSubview(visualEffectView)
    }
    func initAvatar(){
        let avatarRadius:CGFloat = 45
        avatar = UIImageView.init(image: UIImage.init(named: "img_find_default"))
        avatar.isUserInteractionEnabled = true
        avatar.tag = 1000
        avatar.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onTapAction(sender:))))
        containerView.addSubview(avatar)
        let paddingLayer = CALayer.init()
        paddingLayer.frame = CGRect.init(x: 0, y: 0, width: avatarRadius * 2, height: avatarRadius * 2)
        paddingLayer.borderWidth = 2
        paddingLayer.borderColor = ColorWhiteAlpha20.cgColor
        paddingLayer.cornerRadius = avatarRadius
        avatar.layer.addSublayer(paddingLayer)
        avatar.snp.makeConstraints { make in
            make.top.equalTo(self).offset(69 + statusBarHeight)
            make.left.equalTo(self).offset(15)
            make.width.height.equalTo(avatarRadius * 2)
        }
    }
    func initActionsView() {
        settingIcon = UIImageView.init(image: UIImage.init(named: "icon_titlebar_whitemore"))
        settingIcon.contentMode = .center
        settingIcon.layer.backgroundColor = ColorWhiteAlpha20.cgColor
        settingIcon.layer.cornerRadius = 2
        settingIcon.tag = 5000
        settingIcon.isUserInteractionEnabled = true
        settingIcon.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onTapAction(sender:))))
        containerView.addSubview(settingIcon)
        settingIcon.snp.makeConstraints { make in
            make.centerY.equalTo(self.avatar)
            make.right.equalTo(self).inset(15)
            make.width.height.equalTo(40)
        }
        focusIcon = UIImageView.init(image: UIImage.init(named: "icon_titlebar_addfriend"))
        focusIcon.contentMode = .center
        focusIcon.isUserInteractionEnabled = true
        focusIcon.clipsToBounds = true
        focusIcon.isHidden = isFollowed
        focusIcon.layer.backgroundColor = ColorWhiteAlpha20.cgColor
        focusIcon.layer.cornerRadius = 2
        focusIcon.tag = 3000
        focusIcon.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onTapAction(sender:))))
        containerView.addSubview(focusIcon)
        focusIcon.snp.makeConstraints { make in
            make.centerY.equalTo(self.settingIcon)
            make.right.equalTo(self.settingIcon.snp.left).inset(-5)
            make.width.height.equalTo(40)
        }
        
        sendMessage = UILabel.init()
        sendMessage.text = "发消息"
        sendMessage.textColor = ColorWhiteAlpha60
        sendMessage.textAlignment = .center
        sendMessage.font = MediumFont
        sendMessage.isHidden = isFollowed
        sendMessage.layer.backgroundColor = ColorWhiteAlpha20.cgColor
        sendMessage.layer.cornerRadius = 2
        sendMessage.tag = 2000
        sendMessage.isUserInteractionEnabled = true
        sendMessage.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onTapAction(sender:))))
        containerView.addSubview(sendMessage)
        sendMessage.snp.makeConstraints { make in
            make.centerY.equalTo(self.focusIcon)
            make.right.equalTo(self.focusIcon.snp.left).inset(-5)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
        focusButton = UIButton.init()
        focusButton.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 2, bottom: 0, right: 0)
        focusButton.setTitle("关注", for: .normal)
        focusButton.setTitleColor(ColorWhite, for: .normal)
        focusButton.titleLabel?.font = MediumFont
        focusButton.isHidden = true
        focusButton.clipsToBounds = true
        focusButton.layer.cornerRadius = 2
        focusButton.setImage(UIImage.init(named: "icon_personal_add_little"), for: .normal)
        focusButton.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -2, bottom: 0, right: 0)
        focusButton.layer.backgroundColor = ColorThemeRed.cgColor
        focusButton.tag = 3000
        focusButton.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onTapAction(sender:))))
        containerView.addSubview(focusButton)
        focusButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.settingIcon)
            make.right.equalTo(self.settingIcon.snp.left).inset(-5)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
    }
    func initInfoViews(){
        nickName.text = "name"
        nickName.textColor = ColorWhite
        nickName.font = SuperBigBoldFont
        containerView.addSubview(nickName)
        nickName.snp.makeConstraints { make in
            make.top.equalTo(self.avatar.snp.bottom).offset(20)
            make.left.equalTo(self.avatar)
            make.right.equalTo(self.settingIcon)
        }
        douyinNum.text = "识别号：213123123121"
        douyinNum.textColor = ColorWhite
        douyinNum.font = SmallFont
        containerView.addSubview(douyinNum)
        douyinNum.snp.makeConstraints { make in
            make.top.equalTo(self.nickName.snp.bottom).offset(3)
            make.left.right.equalTo(self.nickName)
        }
        let arrow = UIImageView.init(image: UIImage.init(named: "icon_arrow"))
        containerView.addSubview(arrow)
        arrow.snp.makeConstraints { make in
            make.centerY.right.equalTo(self.douyinNum)
            make.width.height.equalTo(12)
        }
        
        github.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 3, bottom: 0, right: 0)
        github.setTitle("Github主页", for: .normal)
        github.setTitleColor(ColorWhite, for: .normal)
        github.titleLabel?.font = SmallFont
        github.setImage(UIImage.init(named: "icon_github"), for: .normal)
        github.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -3, bottom: 0, right: 0)
        github.tag = 6000
        github.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onTapAction(sender:))))
        containerView.addSubview(github)
        github.snp.makeConstraints { make in
            make.centerY.equalTo(self.douyinNum)
            make.right.equalTo(arrow).inset(5)
            make.width.equalTo(92)
        }
        let splitLine = UIView.init()
        splitLine.backgroundColor = ColorWhiteAlpha20
        containerView.addSubview(splitLine)
        splitLine.snp.makeConstraints { make in
            make.top.equalTo(self.douyinNum.snp.bottom).offset(10)
            make.left.right.equalTo(self.nickName)
            make.height.equalTo(0.5)
        }
        brief.text = "编辑个性的签名"
        brief.textColor = ColorWhiteAlpha60
        brief.font = SmallFont
        brief.numberOfLines = 0
        containerView .addSubview(brief)
        brief.snp.makeConstraints { make in
            make.top.equalTo(splitLine.snp.bottom).offset(10)
            make.left.right.equalTo(self.nickName)
        }
        genderIcon.layer.backgroundColor = ColorWhiteAlpha20.cgColor
        genderIcon.layer.cornerRadius = 9
        genderIcon.contentMode = .center
        containerView.addSubview(genderIcon)
        genderIcon.snp.makeConstraints { make in
            make.left.equalTo(self.nickName)
            make.top.equalTo(self.brief.snp.bottom).offset(8)
            make.height.equalTo(18)
            make.width.equalTo(22)
        }
        
        constellation.textColor = ColorWhite
        constellation.text = "座"
        constellation.font = SuperSmallFont
        constellation.isScrollEnabled = false
        constellation.isEditable = false
        constellation.textContainerInset = UIEdgeInsets.init(top: 3, left: 6, bottom: 3, right: 6)
        constellation.textContainer.lineFragmentPadding = 0
        constellation.layer.backgroundColor = ColorWhiteAlpha20.cgColor
        constellation.layer.cornerRadius = 9
        constellation.sizeToFit()
        containerView.addSubview(constellation)
        constellation.snp.makeConstraints { make in
            make.left.equalTo(self.genderIcon.snp.right).offset(5)
            make.top.height.equalTo(self.genderIcon)
        }
        
        likeNum.text = "0获赞"
        likeNum.textColor = ColorWhite
        likeNum.font = BigBoldFont
        containerView.addSubview(likeNum)
        likeNum.snp.makeConstraints { make in
            make.top.equalTo(self.genderIcon.snp.bottom).offset(15)
            make.left.equalTo(self.avatar)
        }
        
        followNum.text = "0关注"
        followNum.textColor = ColorWhite
        followNum.font = BigBoldFont
        containerView.addSubview(followNum)
        followNum.snp.makeConstraints { make in
            make.top.equalTo(self.likeNum)
            make.left.equalTo(self.likeNum.snp.right).offset(30)
        }
        
        followedNum.text = "0粉丝"
        followedNum.textColor = ColorWhite
        followedNum.font = BigBoldFont
        containerView.addSubview(followedNum)
        followedNum.snp.makeConstraints { make in
            make.top.equalTo(self.likeNum)
            make.left.equalTo(self.followNum.snp.right).offset(30)
        }
    }
    @objc func onTapAction(sender: UITapGestureRecognizer) {
        if (self.delegate != nil) {
            self.delegate?.onUserActionTap(tag: (sender.view?.tag)!)
        }
    }
}
extension UserInfoHeader {
    
    func overScrollAction(offsetY:CGFloat)  {
        //计算背景容器缩放比例
        let scaleRatio:CGFloat = abs(offsetY)/370.0
        //计算容器缩放后y方向的偏移量
        let overScaleHeight:CGFloat = (370.0 * scaleRatio)/2.0
        //缩放同时平移背景容器
        avatarBackground.transform = CGAffineTransform.init(scaleX: scaleRatio + 1.0, y: scaleRatio + 1.0).concatenating(CGAffineTransform.init(translationX: 0, y: -overScaleHeight))
    }
    
    func scrollToTopAction(offsetY:CGFloat) {
        let alphaRatio = offsetY/(370.0 - 44.0 - statusBarHeight)
        containerView.alpha = 1.0 - alphaRatio
    }
    
}
