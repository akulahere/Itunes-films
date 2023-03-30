//
//  LoadingSpinner.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 30.03.2023.
//

import UIKit

import UIKit

class LoadingSpinner {
  static let shared = LoadingSpinner()
  private var spinner: UIActivityIndicatorView?
  private var backgroundView: UIView?
  
  func show() {
    guard spinner == nil, backgroundView == nil else { return }
    
    DispatchQueue.main.async {
      let scenes = UIApplication.shared.connectedScenes
      
      let windowScene = scenes.first as? UIWindowScene
      let window = windowScene?.windows.first
      
      let backgroundView = UIView(frame: window?.bounds ?? UIScreen.main.bounds)
      backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
      window?.addSubview(backgroundView)
      self.backgroundView = backgroundView
    
      let spinner = UIActivityIndicatorView(style: .large)
      spinner.color = .systemGreen
      spinner.startAnimating()
      spinner.center = window?.center ?? CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
      backgroundView.addSubview(spinner)
      
      self.spinner = spinner
    }
  }
  
  func hide() {
    DispatchQueue.main.async {
      self.spinner?.removeFromSuperview()
      self.backgroundView?.removeFromSuperview()
      self.spinner = nil
      self.backgroundView = nil
    }
  }
}
