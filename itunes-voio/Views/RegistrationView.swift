//
//  RegistrationView.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 27.03.2023.
//

import UIKit

protocol RegistrationViewDelegate: AnyObject {
    func backButtonTaped()
    func registerButtonTapped()
}

// TODO: Fix capitalazing in the fields

// TODO: Make password  field protected
class RegistrationView: UIView {
  weak var delegate: RegistrationViewDelegate?

  private let registrationLabel = IVTitleLabel(textAlignment: .center, fontSize: 36, text: "Registration")
  let userPicView: UIView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "person.circle")
    imageView.tintColor = .gray
    imageView.contentMode = .scaleAspectFit
    imageView.layer.masksToBounds = true
    imageView.layer.borderWidth = 2
    imageView.layer.borderColor = UIColor.lightGray.cgColor
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 10

    return imageView
  }()
  
  let nameField = IVTextField(placeholderText: "Enter name")
  let emailField = IVTextField(placeholderText: "Enter email")
  let passwordField = IVTextField(placeholderText: "Enter password", isSecured: false)
  let backToLoginButton = IVButton(backgroundColor: .systemGreen, title: "Back to Login")
  let registerButton = IVButton(backgroundColor: .systemGreen, title: "Register")
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    backgroundColor = .systemBackground
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews(registrationLabel, userPicView, emailField, nameField, passwordField, registerButton, backToLoginButton)
    setUpConstraints()
    backToLoginButton.addTarget(self, action: #selector(backButtonTaped), for: .touchUpInside)
    registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
  }
  
  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      registrationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 120),
      registrationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      userPicView.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 48),
      userPicView.centerXAnchor.constraint(equalTo: centerXAnchor),
      userPicView.heightAnchor.constraint(equalToConstant: 80),
      userPicView.widthAnchor.constraint(equalToConstant: 80),
      
      emailField.topAnchor.constraint(equalTo: userPicView.bottomAnchor, constant: 48),
      emailField.centerXAnchor.constraint(equalTo: centerXAnchor),
      emailField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
      
      nameField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 24),
      nameField.centerXAnchor.constraint(equalTo: centerXAnchor),
      nameField.widthAnchor.constraint(equalTo: emailField.widthAnchor),
      
      passwordField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 24),
      passwordField.centerXAnchor.constraint(equalTo: centerXAnchor),
      passwordField.widthAnchor.constraint(equalTo: emailField.widthAnchor),
      
      backToLoginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 36),
      backToLoginButton.leftAnchor.constraint(equalTo: passwordField.leftAnchor),
      backToLoginButton.widthAnchor.constraint(equalTo: emailField.widthAnchor, multiplier: 0.4),
      
      registerButton.topAnchor.constraint(equalTo: backToLoginButton.topAnchor),
      registerButton.rightAnchor.constraint(equalTo: passwordField.rightAnchor),
      registerButton.widthAnchor.constraint(equalTo: emailField.widthAnchor, multiplier: 0.4)
    ])
  }
  
  @objc func backButtonTaped() {
    delegate?.backButtonTaped()
  }
  
  @objc func registerButtonTapped() {
    delegate?.registerButtonTapped()
  }
}

