//
//  Extensions.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 27.03.2023.
//

import UIKit

extension UIView {
  func addSubviews(_ views: UIView...) {
    views.forEach {
      addSubview($0)
    }
  }
}
