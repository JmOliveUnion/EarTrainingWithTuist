//
//  AdvertisingTableViewCell.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/25.
//

import UIKit

class AdvertisingTableViewCell: UITableViewCell {
    
    static let identifier = "AdvertisingTableViewCell"
    
    @IBOutlet weak var advertisingImageView: UIImageView!
    
    static func nib() -> UINib {
        return UINib(nibName: "AdvertisingTableViewCell", bundle: nil)
    }
    
    func configure() {
        advertisingImageView.image = UIImage(named: "OliveAdImage")
        advertisingImageView.contentMode = .scaleAspectFill
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
