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
    delegate = self
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

extension BaseTabBarController: UITabBarControllerDelegate  {
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    
    guard let fromView = selectedViewController?.view, let toView = viewController.view else {
      return false
    }
    
    if fromView != toView {
      UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
    }
    
    return true
  }
}
