//
//  AuthService.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 27.03.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth

import FirebaseFirestore
import FirebaseStorage


final class AuthService {
  static let shared = AuthService()
  
  init() {}
  
  func signUp(email: String, pass: String, name: String, profileImageData: Data, completion: @escaping (Result<String, Error>) -> Void) {
    Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
      if let error = error {
        completion(.failure(error))
      } else {
        guard let userId = result?.user.uid else {
          completion(.failure(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found"])))
          return
        }
        self.uploadUserPhoto(UIImage(data: profileImageData)!, userId: userId) { imageUrlResult in
          switch imageUrlResult {
          case .success(let imageUrl):
//            let userData: [String: Any] = ["email": email, "name": name, "photoUrl": imageUrl]
            // Save the user data
            let newUser = User(uid: userId, email: email, name: name, photoUrl: imageUrl)
            self.saveUserData(user: newUser) { error in
              if let error = error {
                completion(.failure(error))
              } else {
                completion(.success("User registered successfully"))
              }
            }
          case .failure(let error):
            completion(.failure(error))
          }
        }
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
  
  func saveUserData(user: User, completion: @escaping (Error?) -> Void) {
    let db = Firestore.firestore()
    let userData: [String: Any] = [
      "uid": user.uid,
      "email": user.email,
      "name": user.name ?? "",
      "photoUrl": user.photoUrl ?? ""
    ]
    
    db.collection("users").document(user.uid).setData(userData) { error in
      completion(error)
    }
  }
  
  func getUserData(uid: String, completion: @escaping (Result<User, Error>) -> Void) {
    let db = Firestore.firestore()
    db.collection("users").document(uid).getDocument { (document, error) in
      if let error = error {
        completion(.failure(error))
      } else {
        guard let document = document, document.exists,
              let data = document.data(),
              let email = data["email"] as? String else {
          completion(.failure(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
          return
        }
        
        let name = data["name"] as? String
        let photoUrl = data["photoUrl"] as? String
        let appUser = User(uid: uid, email: email, name: name, photoUrl: photoUrl)
        completion(.success(appUser))
      }
    }
  }
  
  func uploadUserPhoto(_ image: UIImage, userId: String, completion: @escaping (Result<String, Error>) -> Void) {
    guard let imageData = image.jpegData(compressionQuality: 0.5) else {
      completion(.failure(NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
      return
    }
    
    let storageRef = Storage.storage().reference().child("userPhotos/\(userId).jpg")
    storageRef.putData(imageData, metadata: nil) { metadata, error in
      if let error = error {
        completion(.failure(error))
      } else {
        storageRef.downloadURL { url, error in
          if let error = error {
            completion(.failure(error))
          } else if let url = url {
            completion(.success(url.absoluteString))
          } else {
            completion(.failure(NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve download URL"])))
          }
        }
      }
    }
  }
}


