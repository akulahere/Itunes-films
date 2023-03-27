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
  
  func registerButtonTapped() {

  }
}
