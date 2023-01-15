//
//  ComicsTableViewCell.swift
//  Marvel-Challenge-2023-Rui.Sousa
//
//  Created by Rui Sousa on 13/01/2023.
//
import UIKit

class ComicsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    var characterDetails: Character!
    var comicList: ComicList? {
        didSet {
            comicsCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        comicsCollectionView.delegate = self
        comicsCollectionView.dataSource = self
        registerCell()
    }
    func registerCell() {
        comicsCollectionView.register(UINib(nibName: "ComicsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "comicsCollectionViewCell")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicList?.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comicsCollectionViewCell", for: indexPath) as! ComicsCollectionViewCell
        
        if let comics = comicList?.items?[indexPath.item] {
            if let name = comics.name {
                cell.comicsTitle.text = name
            } else {
                cell.comicsTitle.text = "N/A"
            }
            if let thumbnailPath = characterDetails.thumbnail?.url {
                cell.img?.sd_setImage(with: thumbnailPath)
            }
        }
        return cell
        func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
    }
}

