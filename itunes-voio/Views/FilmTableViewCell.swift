//
//  FilmTableViewCell.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import UIKit


// TODO: - Fix cells layout
// TODO: - Place image loader in controller
// TODO: - Make name label it two lines
// TODO: - Make smaller font for Genre and year
class FilmTableViewCell: UITableViewCell {
  private let filmImageView: UIImageView = {
    let filmImageView = UIImageView()
    filmImageView.translatesAutoresizingMaskIntoConstraints = false
    return filmImageView
  }()
  
  private let titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    titleLabel.textColor = .label
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.minimumScaleFactor = 0.9
    titleLabel.numberOfLines = 0
    titleLabel.lineBreakMode = .byWordWrapping
    return titleLabel
  }()
  
  private let genreLabel: UILabel = {
    let genreLabel = UILabel()
    genreLabel.translatesAutoresizingMaskIntoConstraints = false
    genreLabel.font = UIFont.systemFont(ofSize: 12, weight: .thin)
    genreLabel.textColor = .secondaryLabel
    genreLabel.adjustsFontSizeToFitWidth = true
    genreLabel.minimumScaleFactor = 0.9
    genreLabel.lineBreakMode = .byTruncatingTail
    return genreLabel
  }()

  private let yearLabel: UILabel = {
    let yearLabel = UILabel()
    yearLabel.translatesAutoresizingMaskIntoConstraints = false
    yearLabel.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
    yearLabel.textColor = .secondaryLabel
    yearLabel.adjustsFontSizeToFitWidth = true
    yearLabel.minimumScaleFactor = 0.9
    yearLabel.lineBreakMode = .byTruncatingTail
    return yearLabel
  }()
  
  private let addToFavoriteButton: UIButton = {
    let addToFavoriteButton = UIButton()
    addToFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
    addToFavoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
    return addToFavoriteButton
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupSubviews() {
//    filmImageView.translatesAutoresizingMaskIntoConstraints = false
//    genreLabel.translatesAutoresizingMaskIntoConstraints = false
//    yearLabel.translatesAutoresizingMaskIntoConstraints = false
//    addToFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
//    addToFavoriteButton.setImage(UIImage(systemName: "star"), for: .normal)

    //     addToFavoriteButton.addTarget(self, action: #selector(addToFavoriteTapped), for: .touchUpInside)
    
    contentView.addSubview(filmImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(genreLabel)
    contentView.addSubview(yearLabel)
    contentView.addSubview(addToFavoriteButton)
    setUpConstraints()
  }
  
  func setUpConstraints() {
    NSLayoutConstraint.activate([
      filmImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      filmImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      filmImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      filmImageView.widthAnchor.constraint(equalToConstant: 80),
      filmImageView.heightAnchor.constraint(equalToConstant: 80),
      
      titleLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 8),
//      titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -38-80-16),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -38),
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      
      
      genreLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
      
      yearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      yearLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 4),
      
      addToFavoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      addToFavoriteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      addToFavoriteButton.heightAnchor.constraint(equalToConstant: 30),
      addToFavoriteButton.widthAnchor.constraint(equalToConstant: 30),

    ])
  }
  
  func configure(with film: FilmInfo) {

    print("Configure cell")
    ItunesService.shared.getFilmImage(url: film.artworkUrl100) { [weak self] image in
      DispatchQueue.main.async {
        if let image = image {
          self?.filmImageView.image = image
        } else {
          self?.filmImageView.image = UIImage(systemName: "film")
        }
      }
    }
      
    titleLabel.text = film.trackName
    genreLabel.text = film.primaryGenreName
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    yearLabel.text = dateFormatter.string(from: film.releaseDate)
  }
}

