//
//  StoriesTableViewCell.swift
//  Marvel-Challenge-2023-Rui.Sousa
//
//  Created by Rui Sousa on 13/01/2023.
//


import UIKit

class StoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
}
