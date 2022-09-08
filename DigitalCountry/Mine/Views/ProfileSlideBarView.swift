//
//  ProfileSlideBarView.swift
//  DigitalCountry
//
//  Created by 倪尛 on 2022/9/7.
//

import UIKit

class ProfileSlideBarView: UICollectionReusableView {
    
    // MARK: - UI Components
    var videoLabel: UILabel!
    var feedLabel: UILabel!
    var likesLabel: UILabel!
    var bottomSlidingLine: CALayer!
    
    enum Section {
         case videos, feed, likes
    }
    var currentSection : Section = .feed
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView() {
        self.backgroundColor = .Background
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(switchAction(sender:)))
        self.addGestureRecognizer(tapGesture)
        
        // video label
        videoLabel = SlideBarLabel()
        videoLabel.text = "视频"
        addSubview(videoLabel)
        videoLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3)
            make.left.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        //feedlabel
        feedLabel = SlideBarLabel()
        feedLabel.text = "收藏"
        addSubview(feedLabel)
        feedLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        //like lable
        likesLabel = SlideBarLabel()
        likesLabel.text = "喜欢"
        addSubview(likesLabel)
        likesLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3)
            make.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        bottomSlidingLine = CALayer()
        bottomSlidingLine.backgroundColor = UIColor.Yellow.cgColor
        bottomSlidingLine.frame = CGRect(x: 0, y: self.frame.size.height - 2, width: self.frame.size.width / 3, height: 2)
        self.layer.addSublayer(bottomSlidingLine)
        
    }
    
    @objc func switchAction(sender: UITapGestureRecognizer){
        let location = sender.location(in: self)
        if videoLabel.frame.contains(location) && currentSection != .videos {
            currentSection = .videos
            
        }else if feedLabel.frame.contains(location) && currentSection != .feed {
            currentSection = .feed
        }else if likesLabel.frame.contains(location) && currentSection != .likes {
            currentSection = .likes
        }
        print(currentSection)
        slideTo(section: currentSection)
    }
    func slideTo(section: Section){
        switch section {
        case .videos:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: [.allowUserInteraction,.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                self.bottomSlidingLine.frame = CGRect(x: 0, y: self.frame.size.height - 2, width: self.frame.size.width / 3, height: 2)
            }, completion: nil)
        case .feed:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: [.allowUserInteraction,.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                self.bottomSlidingLine.frame = CGRect(x: self.frame.size.width / 3, y: self.frame.size.height - 2, width: self.frame.size.width / 3, height: 2)
            }, completion: nil)
        case .likes:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: [.allowUserInteraction,.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                self.bottomSlidingLine.frame = CGRect(x: self.frame.size.width / 3 * 2, y: self.frame.size.height - 2, width: self.frame.size.width / 3, height: 2)
            }, completion: nil)
        }
    }
}
class SlideBarLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .white
        textAlignment = .center
        backgroundColor = .clear
        font = UIFont.systemFont(ofSize: 17, weight: .regular)
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
