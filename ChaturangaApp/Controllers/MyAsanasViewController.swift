//
//  TrainingsViewController.swift
//  Chaturanga
//
//  Created by Alexander Korchak on 07.11.2022.
//


import UIKit
import CoreData

class MyAsanasViewController: AllAsanasViewController {
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func setupSearchBar() {
        self.searchBar.removeFromSuperview()
    }
 
    private lazy var plusButton: UIButton = {
        let button = UIButton()
    
        button.addTarget(self, action: #selector(addAsanas), for: .touchUpInside)
        button.setTitle("Добавить асаны", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.init(white: 0, alpha: 0.8), for: .selected)
        button.setTitleColor(.purple, for: .disabled)
        button.setTitleColor(.purple, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange

        button.layer.cornerRadius = 10
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1.7
        
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Мои асаны"
        self.navigationItem.largeTitleDisplayMode = .never
        setupElements()
        fetchList()
        addEditButton()
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.gray]
        self.navigationItem.standardAppearance = appearance
   
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView.allowsMultipleSelection = editing
        
        collectionView.indexPathsForSelectedItems?.forEach({ (indexPath) in
            collectionView.deselectItem(at: indexPath, animated: false)
        })
        collectionView.indexPathsForVisibleItems.forEach { (indexPath) in
            let cell = collectionView.cellForItem(at: indexPath) as! AllAsanasCustomCellCollectionViewCell
            cell.isAtEditState = editing
           
            editing ? addDeleteButton() : navigationItem.setRightBarButton(nil, animated: true)
      
        }
        self.editButtonItem.title = editing ? "Готово" : "Изменить"
        isEditing ? (plusButton.isEnabled = false) : (plusButton.isEnabled = true)
        
        collectionView.reloadData()
    }
    
    private func addEditButton() {
        if !savedAsanas.isEmpty {
            navigationItem.leftBarButtonItem = editButtonItem
            editButtonItem.title = "Изменить"
        }
    }
    
    private func addDeleteButton() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAction))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func deleteAction() {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            let items = selectedItems.map{ $0.item }.sorted().reversed()
            for item in items {
                deleteItem(item: savedAsanas[item])
                savedAsanas.remove(at: item)
            }
            collectionView.deleteItems(at: selectedItems)
            
            if savedAsanas.isEmpty {
                navigationItem.setRightBarButton(nil, animated: true)
                navigationItem.setLeftBarButton(nil, animated: true)
                plusButton.isEnabled = true
                isEditing = !isEditing
            }
        }
    }
    
    func deleteItem(item: Asanas) {
        
        context.delete(item)
        do {
            try context.save()
        } catch  {

        }
    }

    private func fetchList() {
        do {
            savedAsanas = try context.fetch(Asanas.fetchRequest())
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    private func setupElements() {
        self.view.addSubview(plusButton)
        
        NSLayoutConstraint.activate([

            plusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            plusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            plusButton.heightAnchor.constraint(equalToConstant: 50),
            plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func addAsanas() {
        let viewController = AllAsanasPickerViewController()
        viewController.delegate = self
        self.present(UINavigationController(rootViewController: viewController), animated: true)
    }
    
    override func setupCollectionView() {
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 130),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 50),
        ])
    }
    
 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllAsanasCustomCellCollectionViewCell.identifier, for: indexPath) as? AllAsanasCustomCellCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
        }

        if let picture = savedAsanas[indexPath.row].savedImage {
            if let customImage = UIImage(named: picture) {
                cell.apply(photos: customImage)
            }
        }

        cell.setup(originCell: cell)
        cell.setupSelectLabel()
        cell.isAtEditState = isEditing
        return cell
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        savedAsanas.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

         guard isEditing else  {
            let viewController = AsanaDescriptionViewController()

            viewController.selectedIndex = indexPath.row
             
            if let image = savedAsanas[indexPath.row].savedImage {
                viewController.apply(text: image)

                if let asanaImage = UIImage(named: image) {
                    viewController.loadImage(image: asanaImage)
                }
            }
            pushView(viewController: viewController)
            return
        }
    }
}

extension MyAsanasViewController: AddAsanasDelegate {
    func addAsana(asana: Int) {
        self.dismiss(animated: true) {
            self.addEditButton()
            self.collectionView.reloadData()
        }
    }
}
