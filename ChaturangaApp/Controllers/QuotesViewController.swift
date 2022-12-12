//
//  CatalogOfTrainingsViewController.swift
//  Chaturanga
//
//  Created by MacBook Air on 07.11.2022.
//

import UIKit

class QuotesViewController: UIViewController {
    
    private let networkLayer: NetworkLayer = URLSessionLayer()
    private var myquotes: [Quote] = []
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.setTitle("Tap for Quote", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        button.addTarget(self, action: #selector(getQuote), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var quoteLabel: UILabel = {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          label.numberOfLines = 0
          label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
          label.layer.cornerRadius = 10
          label.clipsToBounds = true
          label.backgroundColor = .orange
          label.textAlignment = .center
          return label
      }()
    
    
    
    @objc private func getQuote() {
        let randomNumber = Int.random(in: 0...myquotes.count-1)
        guard let quote = myquotes[randomNumber].q, let author = myquotes[randomNumber].a  else { return }
        quoteLabel.text = "\(quote)\n\n\(author)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Цитаты для поднятия духа"
        self.navigationItem.largeTitleDisplayMode = .never
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.gray]
        self.navigationItem.standardAppearance = appearance
        view.addSubview(button)
        view.addSubview(quoteLabel)
   
        networkLayer.getAllQuotes { [weak self] result in
            DispatchQueue.main.async {
                do {
                    self?.myquotes = try result.get()
                } catch  {
                    print(error)
                }
            }
        }
        setupLabel()
        setupButton()
    }
    
    
    private func setupButton() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 20),
            //button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupLabel() {
        NSLayoutConstraint.activate([
            quoteLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 35),
            quoteLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            quoteLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            quoteLabel.heightAnchor.constraint(equalToConstant: 150)

        ])
    }


}
