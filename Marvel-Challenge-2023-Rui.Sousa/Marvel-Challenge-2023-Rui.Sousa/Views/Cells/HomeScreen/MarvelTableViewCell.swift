//
//  MarvelTableViewCell.swift
//  Marvel-Challenge-2023-Rui.Sousa
//
//  Created by Rui Sousa on 13/01/2023.
//

import UIKit
class MarvelTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var cellImgView: UIView!
    @IBOutlet weak var titleView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        cellImgView.clipsToBounds = true
        cellImgView.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }

    func configure(with character: Character) {
    // Configure the cell's UI using the character data
        self.movieTitle.text = character.name
        if let urlString = character.thumbnail?.url {
            self.img?.sd_setImage(with: urlString, placeholderImage: UIImage(named: "placeholder"), completed: { (image, error, cacheType, url) in
                if error != nil {
                    print("Error loading image: \(error.debugDescription)")
                }
            })
        }
    }
}
