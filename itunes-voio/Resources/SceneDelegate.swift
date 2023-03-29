//
//  SceneDelegate.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 27.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    let navigationController = UINavigationController()
    let loginVC = LoginViewController()
    navigationController.modalPresentationStyle = .fullScreen
    
    navigationController.pushViewController(loginVC, animated: true)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {
  }
  
  func sceneDidBecomeActive(_ scene: UIScene) {
  }
  
  func sceneWillResignActive(_ scene: UIScene) {
  }
  
  func sceneWillEnterForeground(_ scene: UIScene) {
  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
  }
  
  func logOut() {
    let navigationController = UINavigationController()
    let loginVC = LoginViewController()
    navigationController.modalPresentationStyle = .fullScreen
    
    navigationController.pushViewController(loginVC, animated: true)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
}

