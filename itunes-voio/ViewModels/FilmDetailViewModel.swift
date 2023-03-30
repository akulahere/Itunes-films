//
//  FilmDetailViewModel.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 29.03.2023.
//

import UIKit

class FilmDetailViewModel {
  private let film: FilmInfo
  
  init(film: FilmInfo) {
    self.film = film
  }
  
  func getFilmImage(completion: @escaping (UIImage?) -> Void) {
    ItunesService.shared.getFilmImage(url: film.artworkUrl100) { image in
      DispatchQueue.main.async {
        completion(image)
      }
    }
  }
  
  func getFilmTitle() -> String {
    return film.trackName
  }
  
  func getFilmGenre() -> String {
    return film.primaryGenreName
  }
  func getFilmReleaseDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    let year = dateFormatter.string(from: film.releaseDate)
    return year
  }
  
  func getFilmDescription() -> String {
    return film.longDescription
  }
  
  func getFilmTrailer() -> URL {
    return film.previewURL
  }
  
  func getFilmID() -> Int {
    return film.trackID
  }
  
}
