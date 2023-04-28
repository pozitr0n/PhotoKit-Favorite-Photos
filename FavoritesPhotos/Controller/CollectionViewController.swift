//
//  CollectionViewController.swift
//  FavoritesPhotos
//
//  Created by Raman Kozar on 27/04/2023.
//

import UIKit
import Photos

class CollectionViewController: UICollectionViewController {

    private var favouriteAlbum = PHFetchResult<PHAssetCollection>()
    private var favPhotos: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionViewLayout()
        fillFavouritePhotos()
        
    }
    
    func fillFavouritePhotos() {
        
        favouriteAlbum = PHAssetCollection.fetchAssetCollections(
            with: .smartAlbum,
            subtype: .smartAlbumFavorites,
            options: nil)
        
        let manager = PHImageManager.default()
        
        var coverAsset: PHAsset?
        let collection = favouriteAlbum[0]
        let fetchedAssets = PHAsset.fetchAssets(in: collection, options: nil)
        
        for curIndex in 0...fetchedAssets.count - 1 {
       
            coverAsset = fetchedAssets.object(at: curIndex)
            
            manager.requestImage(for: coverAsset!, targetSize: CGSize(width: 128, height: 128), contentMode: .aspectFill, options: requestOption()) { (image, error) in
                
                guard let image = image else {
                    return
                }

                self.favPhotos.append(image)
                
            }
            
        }
        
    }
    
    func setCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let displayWidth: CGFloat = self.view.frame.width
        layout.itemSize = CGSize(width: (displayWidth / 3.5), height: (displayWidth / 3.5))
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell else {
            fatalError("Unable to dequeue CollectionViewCell")
        }
        
        cell.updateImage(favPhotos[indexPath.row])
    
        return cell
        
    }

    private func requestOption() -> PHImageRequestOptions {
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
        return requestOptions
        
    }
    
}
