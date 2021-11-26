//
//  TabBarController.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 25.11.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.tabBar.tintColor = .purple
        self.tabBar.unselectedItemTintColor = .gray1
        self.viewControllers = createViewControllers()
        self.selectedIndex = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func createViewControllers() -> [UIViewController] {
        var controllers = [UIViewController]()
        
        let charactersViewController = CharactersViewController()
        charactersViewController.tabBarItem = UITabBarItem(title: "Character",
                                                             image: UIImage(named: "character"),
                                                             selectedImage: UIImage(named: "character.fill"))
        let charactersNavigationController = UINavigationController(rootViewController: charactersViewController)
        controllers.append(charactersNavigationController)
        
        let locationsViewController = LocationsViewController()
        locationsViewController.tabBarItem = UITabBarItem(title: "Location",
                                                             image: UIImage(named: "location"),
                                                             selectedImage: UIImage(named: "location.fill"))
        let locationsNavigationController = UINavigationController(rootViewController: locationsViewController)
        controllers.append(locationsNavigationController)
        
        let episodesViewController = EpisodesViewController()
        episodesViewController.tabBarItem = UITabBarItem(title: "Episode",
                                                             image: UIImage(named: "episode"),
                                                             selectedImage: UIImage(named: "episode.fill"))
        let episodesNavigationController = UINavigationController(rootViewController: episodesViewController)
        controllers.append(episodesNavigationController)
          
        return controllers
    }
}
