//
//  RegistrationViewController.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 27.03.2023.
//

import UIKit

class RegistrationViewController: UIViewController, RegistrationViewDelegate {
  private let registrationView = RegistrationView()
  private let viewModel = RegistrationViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(registrationView)
    setUpConstraints()
    registrationView.delegate = self
    viewModel.delegate = self
    registrationView.emailField.delegate = self
    registrationView.passwordField.delegate = self
    
    registrationView.emailField.becomeFirstResponder()
  }
  
  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      registrationView.topAnchor.constraint(equalTo: view.topAnchor),
      registrationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      registrationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      registrationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
  
  
  func backButtonTaped() {
    navigationController?.popViewController(animated: true)
  }
  
  // TODO: Add loader
  func registerButtonTapped() {
    viewModel.email = registrationView.emailField.text ?? ""
    viewModel.password = registrationView.passwordField.text ?? ""
    viewModel.tryToRegister { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let message):
          print(message)
          // TODO: Proceed to the next view
        case .failure(let error):
          self?.showErrorAlert(message: error.localizedDescription)
        }
      }
    }
  }
}

extension RegistrationViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == registrationView.emailField {
      registrationView.passwordField.becomeFirstResponder()
    } else if textField == registrationView.passwordField {
      registerButtonTapped()
    }
    return true
  }
}
