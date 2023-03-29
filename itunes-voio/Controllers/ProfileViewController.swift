//
//  ProfileViewController.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import UIKit

import UIKit

class ProfileViewController: UIViewController {
  private let viewModel = ProfileViewModel()
  private let profileView = ProfileView()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(profileView)
    profileView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    
    viewModel.fetchUserData { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success:
          self?.updateUI()
        case .failure(let error):
          self?.showErrorAlert(message: error.localizedDescription)
        }
      }
    }
  }
  
  private func updateUI() {
    profileView.nameLabel.text = viewModel.getUserName()
    profileView.emailLabel.text = viewModel.getEmail()
    viewModel.downloadProfileImage { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let image):
          self?.profileView.profileImageView.image = image
        case .failure(let error):
          print("Failed to download profile image: \(error.localizedDescription)")
          self?.profileView.profileImageView.image = UIImage(systemName: "person.circle.fill")
        }
      }
    }
    NSLayoutConstraint.activate([
      profileView.topAnchor.constraint(equalTo: view.topAnchor),
      profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  @objc func logoutButtonTapped() {
    viewModel.logout { [weak self] error in
      if let error = error {
        self?.showErrorAlert(message: error.localizedDescription)
      } else {
        // Redirect to the login and remove tabbar
        let sceneDelegate = self?.view.window?.windowScene?.delegate as! SceneDelegate
        sceneDelegate.logOut()
      }
    }
  }
}
