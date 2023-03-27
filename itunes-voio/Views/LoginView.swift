//
//  LoginView.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 27.03.2023.
//

import UIKit

class LoginView: UIView {

  private let loginLabel = IVTitleLabel(textAlignment: .center, fontSize: 36, text: "Log in")
  private let emailField = IVTextField(placeholderText: "Enter email")
  private let passwordField = IVTextField(placeholderText: "Enter password", isSecured: false)
  private let loginButton = IVButton(backgroundColor: .systemGreen, title: "Login")
  private let registerButton = IVButton(backgroundColor: .systemGreen, title: "Register")
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews(loginLabel, emailField, passwordField, loginButton, registerButton)
    backgroundColor = .systemBlue
    setUpConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      loginLabel.topAnchor.constraint(equalTo: topAnchor, constant: 120),
      loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      emailField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 48),
      emailField.centerXAnchor.constraint(equalTo: centerXAnchor),
      emailField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
      
      passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 24),
      passwordField.centerXAnchor.constraint(equalTo: centerXAnchor),
      passwordField.widthAnchor.constraint(equalTo: emailField.widthAnchor),
      
      loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 36),
      loginButton.leftAnchor.constraint(equalTo: passwordField.leftAnchor),
      loginButton.widthAnchor.constraint(equalTo: emailField.widthAnchor, multiplier: 0.4),

      registerButton.topAnchor.constraint(equalTo: loginButton.topAnchor),
      registerButton.rightAnchor.constraint(equalTo: passwordField.rightAnchor),
      registerButton.widthAnchor.constraint(equalTo: emailField.widthAnchor, multiplier: 0.4)
    ])
  }
}
