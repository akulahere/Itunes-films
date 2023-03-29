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
    
    loginView.emailField.delegate = self
    loginView.passwordField.delegate = self
    loginView.emailField.becomeFirstResponder()

  }
  
  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      loginView.topAnchor.constraint(equalTo: view.topAnchor),
      loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
  // TODO: Add loader
  func loginButtonTapped() {
    viewModel.email = loginView.emailField.text ?? ""
    viewModel.password = loginView.passwordField.text ?? ""
    viewModel.tryToLogin { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let message):
          print(message)
          let tabBar = BaseTabBarController()
          self?.navigationController?.setViewControllers([tabBar], animated: true)
        case .failure(let error):
          self?.showErrorAlert(message: error.localizedDescription)
        }
      }
    }
  }
  
  func registerButtonTapped() {
        let registrationVC = RegistrationViewController()
        navigationController?.pushViewController(registrationVC, animated: true)
  }
}

extension LoginViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == loginView.emailField {
      loginView.passwordField.becomeFirstResponder()
    } else if textField == loginView.passwordField {
      loginButtonTapped()
    }
    return true
  }
}
