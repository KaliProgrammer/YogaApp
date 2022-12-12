//
//  SettingsViewController.swift
//  Chaturanga
//
//  Created by MacBook Air on 07.11.2022.
//

import UIKit

class VideoViewController: UIViewController {
    
    var video: [String] = ["aG4b5OvQfp4", "qzSnn1EosOU", "LjpC_a11nU8", "MDw0f8L7QfQ", "TFWcqP1Os34", "G-sdNcaBOQ4"]
    
    private lazy var myCollection: UICollectionView = {
        let screenSize = UIScreen.main.bounds
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        layout.itemSize =  CGSize(width: view.bounds.width-50, height: 200)
        layout.minimumLineSpacing = 36
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.register(VideosCollectionViewCell.self, forCellWithReuseIdentifier: VideosCollectionViewCell.identifier)
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Видео"
        self.navigationItem.largeTitleDisplayMode = .never
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.gray]
        self.navigationItem.standardAppearance = appearance
        setupCollection()
    }
    

    
    private func setupCollection() {
        self.view.addSubview(myCollection)
        self.myCollection.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        NSLayoutConstraint.activate([
            myCollection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            myCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            myCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            myCollection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    


}

extension VideoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        video.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: VideosCollectionViewCell.identifier, for: indexPath) as! VideosCollectionViewCell
        item.loadVideo(with: video[indexPath.row])
        item.backgroundColor = .gray
        item.layer.cornerRadius = 28
        

        return item
    }
    
    
}
