//
//  FilmSearchViewModel.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import Foundation

class FilmSearchViewModel {
  var searchResults: [FilmInfo] = []
  /// Fetch film info using the iTunes API
  func searchFilms(searchTerm: String, completion: @escaping (Error?) -> Void) {
    ItunesService.shared.getFilms(request: searchTerm) { [weak self] result in
      switch result {
      case .success(let films):
        self?.searchResults = films
        completion(nil)
      case .failure(let error):
        completion(error)
      }
    }
  }
}
