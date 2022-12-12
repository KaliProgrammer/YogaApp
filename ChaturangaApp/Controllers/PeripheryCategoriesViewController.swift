//
//  PeripheryCategoriesViewController.swift
//  Chaturanga
//
//  Created by MacBook Air on 10.11.2022.
//

import UIKit

class PeripheryCategoriesViewController: CategoryViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllAsanasCustomCellCollectionViewCell.identifier, for: indexPath) as? AllAsanasCustomCellCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
        }
        
        cell.applyLabel(text: peripheryCategories[indexPath.row].categoryName)
        if let cellImage = UIImage(named: peripheryCategoriesPictures[indexPath.row]) {
            cell.apply(photos: cellImage)
            cell.setOpacity()
        }
      
        cell.setup(cell: cell)
       
        return cell

}
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         peripheryCategories.count
     }
    

}
