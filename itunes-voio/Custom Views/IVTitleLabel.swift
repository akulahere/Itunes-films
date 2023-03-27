//
//  IVTitleLabel.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 27.03.2023.
//

import UIKit

class IVTitleLabel: UILabel {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(textAlignment: NSTextAlignment, fontSize: CGFloat, text: String) {
    super.init(frame: .zero)
    self.textAlignment = textAlignment
    font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    self.text = text
    configure()
  }
  
  private func configure() {
    textColor = .label
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.9
    lineBreakMode = .byTruncatingTail
    translatesAutoresizingMaskIntoConstraints = false
  }
}
