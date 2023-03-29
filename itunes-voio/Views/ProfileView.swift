//
//  ProfileView.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 29.03.2023.
//

import UIKit

class ProfileView: UIView {
  let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 50
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 24)
    return label
  }()
  
  let emailLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 18)
    return label
  }()
  
  let logoutButton = IVButton(backgroundColor: .systemRed, title: "Log out")
//  let logoutButton: UIButton = {
//    let button = UIButton(type: .system)
//    button.translatesAutoresizingMaskIntoConstraints = false
//    button.setTitle("Log Out", for: .normal)
//
//    return button
//  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    setupSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupSubviews() {
    backgroundColor = .systemBackground
    addSubview(profileImageView)
    addSubview(nameLabel)
    addSubview(emailLabel)
    addSubview(logoutButton)
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
      profileImageView.widthAnchor.constraint(equalToConstant: 100),
      profileImageView.heightAnchor.constraint(equalToConstant: 100),
      
      nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 200),
      
      emailLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),
      
      logoutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      logoutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -160),
      logoutButton.widthAnchor.constraint(equalToConstant: 100),
      logoutButton.heightAnchor.constraint(equalToConstant: 40),
    ])
  }
}

