//
//  FavouriteViewModel.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 30.03.2023.
//

import Foundation

final class FavoriteViewModel {
  private let authService = AuthService.shared
  private(set) var favoriteFilmIds: [Int] = []
  private let uid: String
  
  init() {
    self.uid = AuthService.shared.getUserId()
  }
  
  func fetchFavoriteFilmIds(completion: @escaping (Result<Void, Error>) -> Void) {
    authService.fetchFavoriteFilmIds(uid: uid) { [weak self] result in
      switch result {
      case .success(let filmIds):
        self?.favoriteFilmIds = filmIds
        completion(.success(()))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func saveFavoriteFilm(filmId: Int, completion: @escaping (Error?) -> Void) {
    authService.saveFavoriteFilm(uid: uid, filmId: filmId) { [weak self] error in
      if let error = error {
        completion(error)
      } else {
        self?.favoriteFilmIds.append(filmId)
        completion(nil)
      }
    }
  }
  
  func removeFavoriteFilm(filmId: Int, completion: @escaping (Error?) -> Void) {
    authService.removeFavoriteFilm(uid: uid, filmId: filmId) { [weak self] error in
      if let error = error {
        completion(error)
      } else {
        self?.favoriteFilmIds.removeAll(where: { $0 == filmId })
        completion(nil)
      }
    }
  }
  
  func isFavorite(filmId: Int) -> Bool {
    return favoriteFilmIds.contains(filmId)
  }
}
