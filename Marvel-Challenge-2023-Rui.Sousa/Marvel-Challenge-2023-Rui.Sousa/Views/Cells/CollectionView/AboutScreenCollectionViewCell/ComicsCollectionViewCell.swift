//
//  ComicsCollectionViewCell.swift
//  Marvel-Challenge-2023-Rui.Sousa
//
//  Created by Rui Sousa on 13/01/2023.
//


import UIKit

class ComicsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView?
    @IBOutlet weak var comicsTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.img?.layer.cornerRadius = 15
    }

}
