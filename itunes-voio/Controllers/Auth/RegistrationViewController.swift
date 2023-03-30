//
//  RegistrationViewController.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 27.03.2023.
//

import UIKit

class RegistrationViewController: UIViewController, RegistrationViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
    registrationView.userPicView.isUserInteractionEnabled = true
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userPicTapped))
    registrationView.userPicView.addGestureRecognizer(tapGesture)
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
  
  func registerButtonTapped() {
    viewModel.email = registrationView.emailField.text ?? ""
    viewModel.name = registrationView.nameField.text ?? ""
    viewModel.password = registrationView.passwordField.text ?? ""
    viewModel.profileImage = registrationView.userPicView.image
    LoadingSpinner.shared.show()
    viewModel.tryToRegister { [weak self] result in
      DispatchQueue.main.async {
        switch result {

        case .success(let message):
          LoadingSpinner.shared.hide()
          let tabBar = BaseTabBarController()
          self?.navigationController?.setViewControllers([tabBar], animated: true)
        case .failure(let error):
          LoadingSpinner.shared.hide()
          self?.showErrorAlert(message: error.localizedDescription)
        }
      }
    }
  }
  
  @objc func userPicTapped() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.allowsEditing = true
    
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    alertController.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
      imagePickerController.sourceType = .camera
      self.present(imagePickerController, animated: true, completion: nil)
    }))
    alertController.addAction(UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in
      imagePickerController.sourceType = .photoLibrary
      self.present(imagePickerController, animated: true, completion: nil)
    }))
    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    self.present(alertController, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
      registrationView.userPicView.image = editedImage
      viewModel.profileImage = editedImage
    } else {
      viewModel.profileImage = registrationView.userPicView.image
    }
    picker.dismiss(animated: true, completion: nil)
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


