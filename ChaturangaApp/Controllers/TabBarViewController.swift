//
//  TabBarViewController.swift
//  Chaturanga
//
//  Created by Alexander Korchak on 07.11.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private lazy var homeViewController: UINavigationController = {
        let controller = UINavigationController(rootViewController: MainViewController())
        controller.tabBarItem.image = UIImage(systemName: "house.fill")
        controller.tabBarItem.title = "Главная"
        controller.navigationBar.prefersLargeTitles = true
        controller.navigationBar.backgroundColor = .white
        return controller
    }()
    
    private lazy var myAsanasViewController: UINavigationController = {
        let controller = UINavigationController(rootViewController: MyAsanasViewController())
        controller.tabBarItem.image = UIImage(systemName: "person.fill")
        controller.tabBarItem.title = "Мои асаны"
        controller.navigationBar.prefersLargeTitles = true
        controller.navigationBar.backgroundColor = .white
        return controller
    }()
    
    private lazy var quotesViewController: UINavigationController = {
        let controller = UINavigationController(rootViewController: QuotesViewController())
        controller.tabBarItem.image = UIImage(systemName: "list.bullet")
        controller.tabBarItem.title = "Цитаты"
        controller.navigationBar.prefersLargeTitles = true
        controller.navigationBar.backgroundColor = .white
        return controller
    }()
    
    private lazy var videoViewController: UINavigationController = {
        let controller = UINavigationController(rootViewController: VideoViewController())
        controller.tabBarItem.image = UIImage(systemName: "play.circle")
        controller.tabBarItem.title = "Видео"
        controller.navigationBar.prefersLargeTitles = true
        controller.navigationBar.backgroundColor = .white
        return controller
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .orange
        setViewControllers([homeViewController, myAsanasViewController, quotesViewController, videoViewController], animated: true)
        
        if #available(iOS 15, *) {
           
        }
        

             UITabBar.appearance().barTintColor = .white
             UITabBar.appearance().tintColor = .orange
             UITabBar.appearance().isTranslucent = true
             
             if #available(iOS 15.0, *) {
                 let appearance = UITabBarAppearance()
                 appearance.configureWithOpaqueBackground()
                 appearance.backgroundColor = .white
                 UITabBar.appearance().standardAppearance = appearance
                 UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
         
                 let navigationBarAppearance = UINavigationBarAppearance()
                 navigationBarAppearance.configureWithOpaqueBackground()
                 UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
             }
    }
}
