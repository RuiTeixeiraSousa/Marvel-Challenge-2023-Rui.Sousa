//
//  CharacterTitleCell.swift
//  Marvel-Challenge-2023-Rui.Sousa
//
//  Created by Rui Sousa on 13/01/2023.
//

import UIKit

class CharacterTitleCell: UITableViewCell {
    
    @IBOutlet weak var characterTImg: UIImageView!
    @IBOutlet weak var characterViewTitle: UIView!
    @IBOutlet weak var characterTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        characterViewTitle.layer.cornerRadius = 15
        characterViewTitle.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
