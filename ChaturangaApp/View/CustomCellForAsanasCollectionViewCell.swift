//
//  CustomCellForAsanasCollectionViewCell.swift
//  Chaturanga
//
//  Created by MacBook Air on 08.11.2022.
//

import UIKit

class CustomCellForAsanasCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCellForAsanasCollectionViewCell"
    
    private lazy var asanasLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textAlignment = .center
        myLabel.textColor = .white
        myLabel.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLabel
    }()
    
    private lazy var sfSymbol: UIImageView = {
       let myImage = UIImageView()
        myImage.image = UIImage(systemName: "chevron.right")
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.tintColor = .white
       return myImage
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(asanasLabel)
        contentView.addSubview(sfSymbol)
        NSLayoutConstraint.activate([
            asanasLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            asanasLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            asanasLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            asanasLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
            sfSymbol.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            sfSymbol.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            sfSymbol.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        asanasLabel.text = nil
    }
    
    func apply(asanasLabel: String) {
        self.asanasLabel.text = asanasLabel
    }
}
