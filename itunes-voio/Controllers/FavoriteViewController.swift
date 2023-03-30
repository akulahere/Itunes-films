//
//  FavoriteViewController.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  private let favoriteViewModel: FavoriteViewModel
  private var filmDetailsViewModels: [FilmDetailViewModel] = []
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.rowHeight = 96
    tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: "FilmCell")
    return tableView
  }()
  
  init() {
    self.favoriteViewModel = FavoriteViewModel()
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Favorite Films"
    view.backgroundColor = .systemBackground
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    fetchFavoriteFilms()
    tableView.reloadData()
  }
  
  private func setupViews() {
    tableView.dataSource = self
    tableView.delegate = self
    
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  private func fetchFavoriteFilms() {
    favoriteViewModel.fetchFavoriteFilmIds { [weak self] result in
      switch result {
      case .success:
        self?.loadFavoriteFilmDetails()
      case .failure(_):
        print("No favorites")
      }
    }
  }
    
  private func loadFavoriteFilmDetails() {
    let group = DispatchGroup()
    self.filmDetailsViewModels = []
    for filmId in favoriteViewModel.favoriteFilmIds {
      group.enter()
      ItunesService.shared.getFilmInfoBy(id: filmId) { [weak self] result in
        switch result {
        case .success(let filmInfo):
          self?.filmDetailsViewModels.append(FilmDetailViewModel(film: filmInfo))
        case .failure(let error):
          print("Failed to load film with ID \(filmId): \(error.localizedDescription)")
        }
        group.leave()
      }
    }
    
    group.notify(queue: .main) { [weak self] in
      self?.tableView.reloadData()
    }
  }
  
  // UITableViewDataSource methods
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filmDetailsViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmTableViewCell
    let viewModel = filmDetailsViewModels[indexPath.row]
    cell.configure(with: viewModel, isFavorite: true)
    cell.delegate = self
    return cell
  }
  
  // UITableViewDelegate methods
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let detailViewModel = filmDetailsViewModels[indexPath.row]
    let detailViewController = FilmDetailViewController(viewModel: detailViewModel)
    detailViewController.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(detailViewController, animated: true)
  }
}

extension FavoriteViewController: FilmTableViewCellDelegate {
  func addToFavoriteButtonTapped(cell: FilmTableViewCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    let viewModel = filmDetailsViewModels[indexPath.row]
    
    favoriteViewModel.removeFavoriteFilm(filmId: viewModel.getFilmID()) { [weak self] error in
      if let error = error {
        DispatchQueue.main.async {
          self?.showErrorAlert(message: "Failed to remove film with ID \(viewModel.getFilmID()): \(error.localizedDescription)")
        }
      } else {
        DispatchQueue.main.async {
          self?.filmDetailsViewModels.remove(at: indexPath.row)
          self?.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
      }
    }
  }
}
