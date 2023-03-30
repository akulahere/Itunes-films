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
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
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
  
  lazy var shareButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
    return button
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
    view.backgroundColor = .systemBackground
    navigationItem.rightBarButtonItem = shareButton
    setupSubviews()
    setUpConstraints()
  }
  
  private func setupSubviews() {
    view.addSubview(filmImageView)
    view.addSubview(titleLabel)
    view.addSubview(genreLabel)
    view.addSubview(releaseDateLabel)
    view.addSubview(scrollView)
    scrollView.addSubview(descriptionLabel)
    titleLabel.text = viewModel.getFilmTitle()
    genreLabel.text = viewModel.getFilmGenre()
    releaseDateLabel.text = viewModel.getFilmReleaseDate()
    descriptionLabel.text = viewModel.getFilmDescription()
    
    viewModel.getFilmImage { [weak self] image in
      DispatchQueue.main.async {
        self?.filmImageView.image = image ?? UIImage(systemName: "film")
      }
    }
    
    navigationItem.rightBarButtonItem = shareButton
  }
  
  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      filmImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
      filmImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      filmImageView.widthAnchor.constraint(equalToConstant: 150),
      filmImageView.heightAnchor.constraint(equalToConstant: 150),
      
      titleLabel.topAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: 8),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
      
      genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      genreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      
      releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
      
      scrollView.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 8),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      
      descriptionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
      descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
      descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
      descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8),
      descriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16),
    ])
  }
  
  @objc func shareButtonTapped() {
    guard let title = titleLabel.text,
          let releaseDate = releaseDateLabel.text,
          let filmImage = filmImageView.image else { return }
    
    let shareText = "Let's watch together this movie: \(title) (\(releaseDate))!"
    let shareItems: [Any] = [shareText, filmImage]
    
    let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
    activityViewController.excludedActivityTypes = [.addToReadingList, .assignToContact, .markupAsPDF, .openInIBooks, .saveToCameraRoll, .print]
    present(activityViewController, animated: true, completion: nil)
  }
  
}
