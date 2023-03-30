//
//  RegistrationViewModel.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 27.03.2023.
//

import UIKit

final class RegistrationViewModel {
  public weak var delegate: RegistrationViewDelegate?
  var email = ""
  var password = ""
  var name = ""
  var profileImage: UIImage?
  
  func tryToRegister(completion: @escaping (Result<String, Error>) -> Void) {
    guard let profileImageData = profileImage?.jpegData(compressionQuality: 0.5) else {
      completion(.failure(NSError(domain: "Profile image is missing", code: -1, userInfo: nil)))
      return
    }
    AuthService.shared.signUp(email: email, pass: password, name: name, profileImageData: profileImageData) { result in
      switch result {
      case .success(let message):
        completion(.success(message))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  // TODO: Add base field vaildation in VM
  func validateRegistrationForm() {
    
  }
}
