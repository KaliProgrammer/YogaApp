//
//  TransitionViewController.swift
//  ChaturangaApp
//
//  Created by MacBook Air on 14.11.2022.
//

import UIKit

class BackBendViewController: AllAsanasViewController {
    
    override func setupSearchBar() {
            self.searchBar.removeFromSuperview()
        }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllAsanasCustomCellCollectionViewCell.identifier, for: indexPath) as? AllAsanasCustomCellCollectionViewCell else {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
           return cell
       }
       
        if let cellImage = UIImage(named: backBendPhotos[indexPath.row].image) {
           cell.apply(photos: cellImage)
       }
        cell.setup(originCell: cell)

       return cell
}
    
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       backBendPhotos.count
    }
    
   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let viewController = AsanaDescriptionViewController()
           viewController.selectedIndex = indexPath.row
           viewController.imageArray = backBendPhotos
           viewController.apply(text: backBendPhotos[indexPath.row].image)
           if let asanaImage = UIImage(named: backBendPhotos[indexPath.row].image) {
              viewController.loadImage(image: asanaImage)
          }
           pushView(viewController: viewController)
    }
}



