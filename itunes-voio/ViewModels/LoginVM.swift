//
//  LoginVM.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 27.03.2023.
//


import Foundation

protocol LoginVMDelegate: AnyObject {
  func loginButtonTaped()
  func registerButtonTapped()
}

final class LoginVM {
  public weak var delegate: LoginVMDelegate?
  
  func tryLoginUser() {
    
  }
  
  func transitToRegisterScreen() {
    
  }
}
