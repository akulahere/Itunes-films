//
//  User.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 27.03.2023.
//

import Foundation

struct User {
  let uid: String
  let email: String
  let name: String?
  let photoUrl: String?
  let favorites: [String]? = nil
}
