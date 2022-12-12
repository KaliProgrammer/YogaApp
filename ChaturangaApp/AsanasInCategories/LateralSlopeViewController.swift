//
//  LateralSlopeViewController.swift
//  ChaturangaApp
//
//  Created by MacBook Air on 16.11.2022.
//

import UIKit

class LateralSlopeViewController: BackBendViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllAsanasCustomCellCollectionViewCell.identifier, for: indexPath) as? AllAsanasCustomCellCollectionViewCell else {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
           return cell
       }
       
        if let cellImage = UIImage(named: lateralSlopePhotos[indexPath.row].image) {
           cell.apply(photos: cellImage)
       }
        cell.setup(originCell: cell)

       return cell
}
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        lateralSlopePhotos.count
     }
     
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let viewController = AsanaDescriptionViewController()
            viewController.selectedIndex = indexPath.row
            viewController.imageArray = lateralSlopePhotos
            viewController.apply(text: lateralSlopePhotos[indexPath.row].image)
            if let asanaImage = UIImage(named: lateralSlopePhotos[indexPath.row].image) {
               viewController.loadImage(image: asanaImage)
           }
            pushView(viewController: viewController)
     }
    
}
