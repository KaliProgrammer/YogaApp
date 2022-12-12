//
//  ViewControllerForAllAsanas.swift
//  Chaturanga
//
//  Created by MacBook Air on 08.11.2022.
//
import UIKit

class AllAsanasViewController: UIViewController {
    

    var filteredArray: [CustomDataForAllAsanas] = []
    var isFound: Bool?
//    
//    var selectedIndex: Int = 0
//    var imageArray: [CustomDataForAllAsanas] = []
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.delegate = self
        search.tintColor = .gray
        search.contentMode = .top
        search.isTranslucent = true
        search.autocapitalizationType = .words
        search.placeholder = "Введите название асаны"
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var backgroundTapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOutside))
        tap.cancelsTouchesInView = false
        return tap
    }()
    
    @objc func didTapOutside() {
        view.endEditing(true)
    }
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(AllAsanasCustomCellCollectionViewCell.self, forCellWithReuseIdentifier: AllAsanasCustomCellCollectionViewCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor(cgColor: (CGColor(gray: 73.4, alpha: 1.0)))
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupBackgroundView()
        setupCollectionView()
        self.view.addGestureRecognizer(backgroundTapGesture)

    }
    
    func setupBackgroundView() {
        self.view.addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
    
    func setupSearchBar() {
        self.backgroundView.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.backgroundView.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor)
        ])
    }
    
    
    func setupCollectionView() {
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 50),
            
        ])
    }
    
    func allowMultipleSelection() {
        collectionView.allowsMultipleSelection = true
    }
}

extension AllAsanasViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFound ?? false {
            return filteredArray.count
        } else {
            return allAsanasPhotos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: view.frame.size.width/3.3,
            height: view.frame.size.width/3.3
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = AsanaDescriptionViewController()
        viewController.selectedIndex = indexPath.row
        
        guard isFound ?? false else {
            viewController.imageArray = allAsanasPhotos
            viewController.apply(text: allAsanasPhotos[indexPath.row].image)
            if let asanaImage = UIImage(named: allAsanasPhotos[indexPath.row].image) {
                viewController.loadImage(image: asanaImage)
            }
           
            pushView(viewController: viewController)
            return
        }
        viewController.imageArray = filteredArray
        viewController.apply(text: filteredArray[indexPath.row].image)
        if let asanaImage = UIImage(named: filteredArray[indexPath.row].image) {
            viewController.loadImage(image: asanaImage)
        }
       
        pushView(viewController: viewController)
       
        
    }
}

extension AllAsanasViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredArray = allAsanasPhotos
        } else {
            filteredArray = allAsanasPhotos.filter{$0.image.contains(searchText)}
        }
        isFound = true
        collectionView.reloadData()
    }
}
