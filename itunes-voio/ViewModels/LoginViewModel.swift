//
//  LoginViewModel.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 27.03.2023.
//


import UIKit

final class LoginViewModel {
  public weak var delegate: LoginViewDelegate?
  var email = ""
  var password = ""
  
  func tryToLogin(completion: @escaping (Result<String, Error>) -> Void) {
    AuthService.shared.signIn(email: email, pass: password, completion: completion)
  }
  
  // TODO: Add base field vaildation in VM
  func validateLoginForm() {

  }
}
