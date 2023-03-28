//
//  FilmSearchingViewController.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import UIKit

class FilmSearchingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
  private let viewModel = FilmSearchViewModel()
  private let searchBar = UISearchBar()
  private let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Film Searching"
    view.backgroundColor = .white
    
    setupSearchBar()
    setupTableView()
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
    tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: "FilmCell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
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
    return viewModel.searchResults.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmTableViewCell
    let film = viewModel.searchResults[indexPath.row]
    cell.configure(with: film)
    return cell
  }
  
  // UITableViewDelegate methods
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let film = viewModel.searchResults[indexPath.row]
    let detailViewController = FilmDetailViewController(film: film)
    navigationController?.pushViewController(detailViewController, animated: true)
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
    viewModel.searchFilms(searchTerm: searchTerm) { [weak self] error in
      DispatchQueue.main.async {
        if let error = error {
          print("Error searching films: \(error.localizedDescription)")
        } else {
          self?.tableView.reloadData()
        }
      }
    }
  }
}
