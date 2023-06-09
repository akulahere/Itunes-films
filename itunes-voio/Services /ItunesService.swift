//
//  ItunesService.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import UIKit

final class ItunesService {
  static let shared = ItunesService()
  
  init() {}
  
  func getFilms(request: String, completion: @escaping (Result<[FilmInfo], Error>) -> Void) {
    var urlComponents = URLComponents(string: "https://itunes.apple.com/search")
    urlComponents?.queryItems = [
      URLQueryItem(name: "term", value: request),
      URLQueryItem(name: "media", value: "movie"),
      URLQueryItem(name: "limit", value: "50")
    ]
    
    guard let url = urlComponents?.url else {
      completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      guard let data = data else {
        completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
        return
      }
      do {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let searchResponse = try decoder.decode(ItunesResponse.self, from: data)
        completion(.success(searchResponse.results))
      } catch {
        completion(.failure(error))
      }
    }
    
    task.resume()
  }
  
  func getFilmImage(url: URL, completion: @escaping (UIImage?) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if error != nil {
        completion(nil)
        return
      }
      guard let data = data, let image = UIImage(data: data) else {
        completion(nil)
        return
      }
      completion(image)
    }
    task.resume()
  }
  
  func getFilmInfoBy(id: Int, completion: @escaping (Result<FilmInfo, Error>) -> Void) {
    var urlComponents = URLComponents(string: "https://itunes.apple.com/lookup")
    urlComponents?.queryItems = [
      URLQueryItem(name: "id", value: "\(id)"),
      URLQueryItem(name: "entity", value: "movie")
    ]
    
    guard let url = urlComponents?.url else {
      completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      guard let data = data else {
        completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
        return
      }
      do {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let lookupResponse = try decoder.decode(ItunesResponse.self, from: data)
        if let filmInfo = lookupResponse.results.first {
          completion(.success(filmInfo))
        } else {
          completion(.failure(NSError(domain: "Film not found", code: 0, userInfo: nil)))
        }
      } catch {
        completion(.failure(error))
      }
    }
    
    task.resume()
  }
}


