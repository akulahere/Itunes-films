//
//  AuthService.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 27.03.2023.
//

import UIKit
import FirebaseCore
//import FirebaseFirestore
import FirebaseAuth

final class AuthService {
  static let shared = AuthService()
  
  init() {}
  
  
  
  func signUp(email: String, pass: String, completion: @escaping (Result<String, Error>) -> Void) {
    Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
      if let error = error {
        completion(.failure(error))
      } else {
        completion(.success("User login successfully"))
      }
    }
  }
  
  func signIn(email: String, pass: String, completion: @escaping (Result<String, Error>) -> Void) {
    Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
      if let error = error {
        completion(.failure(error))
      } else {
        completion(.success("User login successfully"))
      }
    }
  }
}
