//
//  AchivementTableViewCell.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/25.
//

import UIKit

class AchivementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var calenderImage: UIImageView!

    static let identifier = "AchivementTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AchivementTableViewCell", bundle: nil)
    }
    
    func configure() {
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = "Achivement_Title".localized
        titleLabel.font = .Roboto_B18
        
        calenderImage.image = UIImage(named: Image.homeTabSelected.rawValue)
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
