//
//  ComicsTableViewCell.swift
//  Marvel-Challenge-2023-Rui.Sousa
//
//  Created by Rui Sousa on 13/01/2023.
//
import UIKit

class ComicsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        
    }
    func registerCell() {
        comicsCollectionView.register(UINib(nibName: "ComicsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "comicsCollectionViewCell")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comicsCollectionViewCell", for: indexPath) as! ComicsCollectionViewCell
        return cell
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}