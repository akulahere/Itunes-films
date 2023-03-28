//
//  BaseTabBarController.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import UIKit

class BaseTabBarController: UITabBarController {
  override func viewDidLoad() {
      super.viewDidLoad()
      setupViewControllers()
  }

  private func setupViewControllers() {
      let filmSearchingViewController = FilmSearchingViewController()
      filmSearchingViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))

      let favoriteViewController = FavoriteViewController()
      favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))

      let profileViewController = ProfileViewController()
      profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))

      viewControllers = [
          UINavigationController(rootViewController: filmSearchingViewController),
          UINavigationController(rootViewController: favoriteViewController),
          UINavigationController(rootViewController: profileViewController)
      ]
  }
}
