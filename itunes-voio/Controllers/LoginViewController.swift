//
//  LoginViewController.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 27.03.2023.
//

import UIKit

class LoginViewController: UIViewController, LoginViewDelegate {
  private let loginView = LoginView()
  private let viewModel = LoginViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(loginView)

    setUpConstraints()
    
    loginView.delegate = self
    viewModel.delegate = self
  }
  
  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      loginView.topAnchor.constraint(equalTo: view.topAnchor),
      loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
  
  func loginButtonTapped() {
    viewModel.tryLoginUser()
  }
  
  func registerButtonTapped() {
        let registrationVC = RegistrationViewController()
        navigationController?.pushViewController(registrationVC, animated: true)
  }
}

