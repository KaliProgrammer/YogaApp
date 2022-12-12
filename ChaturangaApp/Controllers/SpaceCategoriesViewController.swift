//
//  SpaceCategoriesViewController.swift
//  Chaturanga
//
//  Created by MacBook Air on 10.11.2022.
//

import UIKit

class SpaceCategoriesViewController: CategoryViewController {

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllAsanasCustomCellCollectionViewCell.identifier, for: indexPath) as? AllAsanasCustomCellCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
        }
        
        cell.applyLabel(text: spaceCategories[indexPath.row].categoryName)
        if let cellImage = UIImage(named: spaceCategoriesPictures[indexPath.row]) {
            cell.apply(photos: cellImage)
            cell.setOpacity()
        }
      
        cell.setup(cell: cell)
       
        return cell

}
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         spaceCategories.count
     }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let viewController = StandingViewController()
            navigationController?.pushViewController(viewController, animated: true)
            
        case 1:
            let viewController = HandStandsViewController()
            navigationController?.pushViewController(viewController, animated: true)
            
        case 2:
            let viewController = SittingViewController()
            navigationController?.pushViewController(viewController, animated: true)
            
        case 3:
            let viewController = ProneViewController()
            navigationController?.pushViewController(viewController, animated: true)
            
            
     

        default:
            return
        }
    }
    
}
