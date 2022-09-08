//
//  ProfileHeaderView.swift
//  DigitalCountry
//
//  Created by 倪尛 on 2022/9/7.
//
import UIKit

class ProfileHeaderView: UICollectionReusableView {

    @IBOutlet weak var proFileHeader: UIImageView! {
        didSet{
            proFileHeader.layer.cornerRadius = proFileHeader.frame.width / 2
            proFileHeader.layer.borderWidth = 1
            proFileHeader.layer.borderColor = UIColor.Background?.cgColor
        }
    }
    
    @IBOutlet weak var editProfileButton: UIButton!{
        didSet{
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
}
