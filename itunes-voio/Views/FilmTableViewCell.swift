//
//  FilmTableViewCell.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import UIKit


// TODO: - Place image loader in controller

protocol FilmTableViewCellDelegate: AnyObject {
    func addToFavoriteButtonTapped(cell: FilmTableViewCell)
}

class FilmTableViewCell: UITableViewCell {
  weak var delegate: FilmTableViewCellDelegate?

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
    addToFavoriteButton.addTarget(self, action: #selector(addToFavoriteButtonTapped), for: .touchUpInside)
    setupSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupSubviews() {    
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
  
  func configure(with film: FilmDetailViewModel, isFavorite: Bool) {
    
    print("Configure cell")
    film.getFilmImage { [weak self] image in
      DispatchQueue.main.async {
        self?.filmImageView.image = image ?? UIImage(systemName: "film")
      }
    }
    
    titleLabel.text = film.getFilmTitle()
    genreLabel.text = film.getFilmGenre()
    yearLabel.text = film.getFilmReleaseDate()
    
    addToFavoriteButton.setImage(UIImage(systemName: isFavorite ? "star.fill" : "star"), for: .normal)
  }
  
  @objc private func addToFavoriteButtonTapped() {
      delegate?.addToFavoriteButtonTapped(cell: self)
  }

  func updateFavoriteButtonImage(isFavorite: Bool) {
      addToFavoriteButton.setImage(UIImage(systemName: isFavorite ? "star.fill" : "star"), for: .normal)
  }
}

