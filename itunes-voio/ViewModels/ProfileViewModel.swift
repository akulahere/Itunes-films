//
//  ProfileViewModel.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 29.03.2023.
//

import Foundation
import FirebaseAuth
import UIKit

final class ProfileViewModel {
  private var user: User
  
  static func create(completion: @escaping (Result<ProfileViewModel, Error>) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else {
      completion(.failure(NSError(domain: "ProfileViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
      return
    }
    
    AuthService.shared.getUserData(uid: uid) { result in
      switch result {
      case .success(let user):
        let viewModel = ProfileViewModel(user: user)
        completion(.success(viewModel))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  init(user: User) {
    self.user = user
  }
  
  func getUserName() -> String? {
    return user.name
  }
  
  func getEmail() -> String? {
    return user.email
  }
  
  func getPhotoUrl() -> String? {
    return user.photoUrl
  }
  
  func getFavorites() -> [Int]? {
    return user.favorites
  }
  
  func downloadProfileImage(completion: @escaping (Result<UIImage, Error>) -> Void) {
    guard let urlString = getPhotoUrl(), let url = URL(string: urlString) else {
      completion(.failure(NSError(domain: "ProfileViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid image URL"])))
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        completion(.failure(error))
      } else if let data = data, let image = UIImage(data: data) {
        completion(.success(image))
      } else {
        completion(.failure(NSError(domain: "ProfileViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to download image"])))
      }
    }.resume()
  }
  
  func logout(completion: @escaping (Error?) -> Void) {
    do {
      try Auth.auth().signOut()
      completion(nil)
    } catch let signOutError {
      completion(signOutError)
    }
  }
  
  func fetchUserData(completion: @escaping (Result<Void, Error>) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else {
      completion(.failure(NSError(domain: "ProfileViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
      return
    }
    
    AuthService.shared.getUserData(uid: uid) { [weak self] result in
      switch result {
      case .success(let user):
        self?.user = user
        completion(.success(()))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
