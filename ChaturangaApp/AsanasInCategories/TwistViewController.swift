//
//  TwistViewController.swift
//  ChaturangaApp
//
//  Created by MacBook Air on 16.11.2022.
//

import UIKit

class TwistViewController: BackBendViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllAsanasCustomCellCollectionViewCell.identifier, for: indexPath) as? AllAsanasCustomCellCollectionViewCell else {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
           return cell
       }
       
        if let cellImage = UIImage(named: twistPhotos[indexPath.row].image) {
           cell.apply(photos: cellImage)
       }
        cell.setup(originCell: cell)

       return cell
}
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        twistPhotos.count
     }
     
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let viewController = AsanaDescriptionViewController()
            viewController.selectedIndex = indexPath.row
            viewController.imageArray = twistPhotos
            viewController.apply(text: twistPhotos[indexPath.row].image)
            if let asanaImage = UIImage(named: twistPhotos[indexPath.row].image) {
               viewController.loadImage(image: asanaImage)
           }
            pushView(viewController: viewController)
     }
    
}
