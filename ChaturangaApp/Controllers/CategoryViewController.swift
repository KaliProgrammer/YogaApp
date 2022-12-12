//
//  CategoryViewController.swift
//  Chaturanga
//
//  Created by MacBook Air on 10.11.2022.
//

import UIKit

class CategoryViewController: AllAsanasViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Категории"
    }
    
    override func setupSearchBar() {
            self.searchBar.removeFromSuperview()
        }
        
       override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllAsanasCustomCellCollectionViewCell.identifier, for: indexPath) as? AllAsanasCustomCellCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                return cell
            }
            
            cell.applyLabel(text: spineCategories[indexPath.row].categoryName)
            if let cellImage = UIImage(named: spineCategoriesPictures[indexPath.row]) {
                cell.apply(photos: cellImage)
                cell.setOpacity()
            }
           cell.setup(cell: cell)
           
           
            return cell
        }
        
       override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            spineCategories.count
        }
        
       override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(
                width: collectionView.frame.size.width/2.3,
                height: collectionView.frame.size.width/2.3
                )
        }
        
       override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 8
            }


        override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 44
            }
            
           override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
               if (UIDevice.current.userInterfaceIdiom == .pad) {
                   return UIEdgeInsets(top: 56, left: 34, bottom: 8, right: 35)
               } else {
                   return UIEdgeInsets(top: 56, left: 14, bottom: 8, right: 14)
               }
            }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let viewController = BackBendViewController()
            navigationController?.pushViewController(viewController, animated: true)
            
        case 1:
            let viewController = ForwardViewController()
            navigationController?.pushViewController(viewController, animated: true)
            
        case 2:
            let viewController = TwistViewController()
            navigationController?.pushViewController(viewController, animated: true)
            
        case 3:
            let viewController = LateralSlopeViewController()
            navigationController?.pushViewController(viewController, animated: true)

        default:
            return
        }
    }
}
