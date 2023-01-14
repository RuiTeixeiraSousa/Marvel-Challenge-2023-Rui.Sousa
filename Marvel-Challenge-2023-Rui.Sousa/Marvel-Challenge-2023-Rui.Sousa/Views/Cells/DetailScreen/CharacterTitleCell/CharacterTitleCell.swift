//
//  CharacterTitleCell.swift
//  Marvel-Challenge-2023-Rui.Sousa
//
//  Created by Rui Sousa on 13/01/2023.
//

import UIKit

class CharacterTitleCell: UITableViewCell {
    
    @IBOutlet weak var CharacterTImg: UIImageView!
    @IBOutlet weak var CharacterViewTitle: UIView!
    @IBOutlet weak var CharacterTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CharacterViewTitle.layer.cornerRadius = 15
        CharacterViewTitle.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
