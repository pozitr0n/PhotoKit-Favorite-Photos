//
//  CollectionViewCell.swift
//  FavoritesPhotos
//
//  Created by Raman Kozar on 27/04/2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "Cell"
    
    @IBOutlet weak var favImageView: UIImageView!
    
    func updateImage(_ currImage: UIImage) {
        favImageView.image = currImage
    }
    
}
