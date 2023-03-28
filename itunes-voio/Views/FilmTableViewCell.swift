//
//  FilmTableViewCell.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import UIKit



class FilmTableViewCell: UITableViewCell {
  private let filmImageView = UIImageView()
  private let titleLabel = UILabel()
  private let genreLabel = UILabel()
  private let yearLabel = UILabel()
  private let addToFavoriteButton = UIButton()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupSubviews() {
    // Set up the subviews and add constraints
  }
  
  func configure(with film: FilmInfo) {
    // Configure the subviews with the film data
  }
}

