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
  
  func tryToRegister(completion: @escaping (Result<String, Error>) -> Void) {
    AuthService.shared.signUp(email: email, pass: password, completion: completion)
  }

  // TODO: Add base field vaildation in VM
  func validateRegistrationForm() {

  }
}
