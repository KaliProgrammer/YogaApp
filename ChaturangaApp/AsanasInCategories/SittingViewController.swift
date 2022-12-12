//
//  SittingViewController.swift
//  ChaturangaApp
//
//  Created by MacBook Air on 06.12.2022.
//

import UIKit

class SittingViewController: BackBendViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllAsanasCustomCellCollectionViewCell.identifier, for: indexPath) as? AllAsanasCustomCellCollectionViewCell else {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
           return cell
       }
       
        if let cellImage = UIImage(named: sittingPhotos[indexPath.row].image) {
           cell.apply(photos: cellImage)
       }
        cell.setup(originCell: cell)

       return cell
}
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sittingPhotos.count
     }
     
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let viewController = AsanaDescriptionViewController()
            viewController.selectedIndex = indexPath.row
            viewController.imageArray = sittingPhotos
            viewController.apply(text: sittingPhotos[indexPath.row].image)
            if let asanaImage = UIImage(named: sittingPhotos[indexPath.row].image) {
               viewController.loadImage(image: asanaImage)
           }
            pushView(viewController: viewController)
     }




}
