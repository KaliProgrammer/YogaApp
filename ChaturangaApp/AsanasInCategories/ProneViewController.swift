//
//  ProneViewController.swift
//  ChaturangaApp
//
//  Created by MacBook Air on 06.12.2022.
//

import UIKit

class ProneViewController: BackBendViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllAsanasCustomCellCollectionViewCell.identifier, for: indexPath) as? AllAsanasCustomCellCollectionViewCell else {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
           return cell
       }
       
        if let cellImage = UIImage(named: pronePhotos[indexPath.row].image) {
           cell.apply(photos: cellImage)
       }
        cell.setup(originCell: cell)

       return cell
}
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pronePhotos.count
     }
     
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let viewController = AsanaDescriptionViewController()
            viewController.selectedIndex = indexPath.row
            viewController.imageArray = pronePhotos
            viewController.apply(text: pronePhotos[indexPath.row].image)
            if let asanaImage = UIImage(named: pronePhotos[indexPath.row].image) {
               viewController.loadImage(image: asanaImage)
           }
            pushView(viewController: viewController)
     }



}
