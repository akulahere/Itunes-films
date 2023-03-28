//
//  ItunesService.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import Foundation

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
}

