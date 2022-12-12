//
//  ViewController.swift
//  Chaturanga
//
//  Created by Alexander Korchak on 07.11.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var navigationCollection: UICollectionView = {
        let screenSize = UIScreen.main.bounds
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        layout.itemSize =  CGSize(width: view.bounds.width-50, height: 60)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.register(CustomCellForAsanasCollectionViewCell.self, forCellWithReuseIdentifier: CustomCellForAsanasCollectionViewCell.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupCollection()
        setupNavigationBar()
        setupLogoImage()
    }
    
    private lazy var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        logo.image = UIImage(named: "Logo")
        return logo
        
    }()
    
    private func setupLogoImage() {
        self.view.addSubview(logoImage)
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            logoImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            logoImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            logoImage.bottomAnchor.constraint(equalTo: navigationCollection.topAnchor),
        ])
    }
  
    private func setupNavigationBar() {
        self.navigationItem.title = "Главная"
        self.navigationItem.largeTitleDisplayMode = .never
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.gray]
        self.navigationItem.standardAppearance = appearance
    }
    
    private func setupCollection() {
        self.view.addSubview(navigationCollection)
        self.navigationCollection.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        NSLayoutConstraint.activate([
            navigationCollection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 120),
            navigationCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navigationCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            navigationCollection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        asanasData.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellForAsanasCollectionViewCell.identifier, for: indexPath) as! CustomCellForAsanasCollectionViewCell
        item.apply(asanasLabel: asanasData[indexPath.row].asana)
        item.backgroundColor = .orange
        item.layer.cornerRadius = 28
        return item
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = AllAsanasViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = CategoryViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = SpaceCategoriesViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = StressFocusCategoriesViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = PeripheryCategoriesViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = AdditionalCategoriesViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}
