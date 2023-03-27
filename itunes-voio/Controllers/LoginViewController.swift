//
//  LoginViewController.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 27.03.2023.
//

import UIKit

class LoginViewController: UIViewController {
  private let loginView = LoginView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(loginView)
    setUpConstraints()
  }
  
  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      loginView.topAnchor.constraint(equalTo: view.topAnchor),
      loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}

