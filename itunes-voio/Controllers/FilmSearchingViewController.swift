//
//  FilmSearchingViewController.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import UIKit

class FilmSearchingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
  private let viewModel = FilmSearchViewModel()
  private let favoriteViewModel = FavoriteViewModel()
  private let searchBar = UISearchBar()
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.rowHeight = 96 // Size of the biggest element (film view + padding
    tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: "FilmCell")
    
    
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Film Searching"
    view.backgroundColor = .systemBackground
    
    setupSearchBar()
    setupTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    favoriteViewModel.fetchFavoriteFilmIds(completion: { result in
      DispatchQueue.main.async { [weak self] in
      switch result {
        case .success(_):
          self?.tableView.reloadData()
        case .failure(_):
          self?.showErrorAlert(message: "Error with updating)")
        }
      }
    })
  }
  
  private func setupSearchBar() {
    searchBar.delegate = self
    searchBar.placeholder = "Search Films"
    searchBar.sizeToFit()
    navigationItem.titleView = searchBar
  }
  
  private func setupTableView() {
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
  
  
  // UITableViewDataSource methods
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getResultsCount()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmTableViewCell
    
    let detailViewModel = FilmDetailViewModel(film: viewModel.getFilmInfo(index: indexPath.row))
    
    let isFavorite = favoriteViewModel.isFavorite(filmId: detailViewModel.getFilmID())
    cell.configure(with: detailViewModel, isFavorite: isFavorite)
    cell.delegate = self
    cell.configure(with: detailViewModel, isFavorite: isFavorite)
    return cell
  }
  
  
  // UITableViewDelegate methods
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let film = viewModel.getFilmInfo(index: indexPath.row)
    let detailViewModel = FilmDetailViewModel(film: film)
    let detailViewController = FilmDetailViewController(viewModel: detailViewModel)
    detailViewController.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(detailViewController, animated: true)
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
    LoadingSpinner.shared.show()
    viewModel.searchFilms(searchTerm: searchTerm) { [weak self] error in
      LoadingSpinner.shared.hide()
      DispatchQueue.main.async {
        if let error = error {
          self?.showErrorAlert(message: error.localizedDescription)
        } else {
          self?.tableView.reloadData()
        }
      }
    }
  }
}

extension FilmSearchingViewController: FilmTableViewCellDelegate {
  func addToFavoriteButtonTapped(cell: FilmTableViewCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    let filmID = viewModel.getFilmId(index: indexPath.row)
    let isFavorite = favoriteViewModel.isFavorite(filmId: filmID)
    
    if isFavorite {
      favoriteViewModel.removeFavoriteFilm(filmId: filmID) { [weak self] error in
        DispatchQueue.main.async {
          if let error = error {
            self?.showErrorAlert(message: "Error removing film from favorites: \(error.localizedDescription)")
          } else {
            cell.updateFavoriteButtonImage(isFavorite: false)
          }
        }

      }
    } else {
      favoriteViewModel.saveFavoriteFilm(filmId: filmID) { [weak self] error in
        DispatchQueue.main.async {
          if let error = error {
            self?.showErrorAlert(message: "Error adding film to favorites: \(error.localizedDescription)")
          } else {
            cell.updateFavoriteButtonImage(isFavorite: true)
          }
        }

      }
    }
  }
}
