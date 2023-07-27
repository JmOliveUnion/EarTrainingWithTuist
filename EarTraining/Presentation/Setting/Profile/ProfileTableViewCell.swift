//
//  ProfileTableViewCell.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/25.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileTableViewCell"
    
    @IBOutlet weak var profileTitleLabel: UILabel!
    @IBOutlet weak var profileEditImageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "ProfileTableViewCell", bundle: nil)
    }
    
    public func configure(profileImage: String, name: String, email: String) {
        profileImageView.image = UIImage(named: profileImage)
        nameLabel.text = name
        emailLabel.text = email
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileTitleLabel.text = "Profile_Title".localized
        profileTitleLabel.font = .Roboto_B32
        
        profileEditImageView.image = UIImage(named: "HomeTab")
        
        nameLabel.font = .Roboto_B18
        emailLabel.font = .Roboto_R16
        emailLabel.textColor = .l_gray100
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
