//
//  AllAsanasPickerViewController.swift
//  ChaturangaApp
//
//  Created by MacBook Air on 21.11.2022.
//

import UIKit
import CoreData

protocol AddAsanasDelegate {
    func addAsana(asana: Int)
}

class AllAsanasPickerViewController: AllAsanasViewController {
    
    var delegate: AddAsanasDelegate?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allowMultipleSelection()
        setNavigationItem()
        
    }
    
    func  setNavigationItem() {
            let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItems))
            self.navigationItem.rightBarButtonItem = rightBarButtonItem

        
            let leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .done, target: self, action: #selector(goBack))
            self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
    }
    
    
    //ADD BUTTON
    
    @objc func addItems() {
        for item in asanasNames {
            createItem(image: item.image)
        }
        let count = savedAsanas.count
        delegate?.addAsana(asana: count)
        asanasNames.removeAll()
    }
    
 
    @objc func goBack() {
        self.dismiss(animated: true, completion: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllAsanasCustomCellCollectionViewCell.identifier, for: indexPath) as? AllAsanasCustomCellCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
        }
        if (!(isFound ?? false)) {
            if let customImage = UIImage(named: allAsanasPhotos[indexPath.row].image) {
                cell.apply(photos: customImage)
            }
        } else {
            if let customImage = UIImage(named: filteredArray[indexPath.row].image) {
                cell.apply(photos: customImage)
            }
        }
        
        cell.setup(originCell: cell)
        
        if asanasNames.contains(allAsanasPhotos[indexPath.row]) {
            cell.backgroundColor = .purple
            if !cell.isSelected {
                cell.prepareForReuse()
            }
        }
        if !filteredArray.isEmpty {
            if asanasNames.contains(filteredArray[indexPath.row]) {
                cell.backgroundColor = .purple
            }
        }
       
        return cell
    }
    
    private func createItem(image: String) {
        let newItem = Asanas(context: context)
        newItem.savedImage = image
        savedAsanas.append(newItem)
        do {
            try self.context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        
        guard (isFound ?? false) else {
            let cell = collectionView.cellForItem(at: indexPath)
            asanasNames.append(allAsanasPhotos[indexPath.row])
            cell?.backgroundColor = .purple
            cell?.isSelected = true
            return
        }
        let cell = collectionView.cellForItem(at: indexPath)
        asanasNames.append(filteredArray[indexPath.row])
        cell?.backgroundColor = .purple
        cell?.isSelected = true
        
        
        
    }
    
     func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
         let cell = collectionView.cellForItem(at: indexPath)
         cell?.backgroundColor = .white
         if asanasNames.contains(allAsanasPhotos[indexPath.row]) {
             asanasNames.removeAll { $0 == allAsanasPhotos[indexPath.row] }
             
         } else if asanasNames.contains(filteredArray[indexPath.row]) {
             asanasNames.removeAll { $0 == filteredArray[indexPath.row] }
         }
    }
}
