//
//  FilmDetailViewController.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import UIKit

class FilmDetailViewController: UIViewController {
  private let viewModel: FilmDetailViewModel
  
  private let filmImageView: UIImageView = {
    let filmImageView = UIImageView()
    filmImageView.translatesAutoresizingMaskIntoConstraints = false
    return filmImageView
  }()
  
  private let titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    titleLabel.numberOfLines = 0
    titleLabel.textAlignment = .center
    return titleLabel
  }()
  
  private let genreLabel: UILabel = {
    let genreLabel = UILabel()
    genreLabel.translatesAutoresizingMaskIntoConstraints = false
    return genreLabel
  }()
  
  private let releaseDateLabel: UILabel = {
    let releaseDateLabel = UILabel()
    releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
    return releaseDateLabel
  }()
  
  private let descriptionLabel: UILabel = {
    let descriptionLabel = UILabel()
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.numberOfLines = 0
    return descriptionLabel
  }()
  
  init(viewModel: FilmDetailViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviews()
  }
  
  private func setupSubviews() {
    view.addSubview(filmImageView)
    view.addSubview(titleLabel)
    view.addSubview(genreLabel)
    view.addSubview(releaseDateLabel)
    view.addSubview(descriptionLabel)
    
//    titleLabel.text = film.trackName
//    genreLabel.text = film.primaryGenreName
  }
  
  // Implement the function to set up the layout
  private func setUpConstraints() {
    // Add constraints here
  }
}
