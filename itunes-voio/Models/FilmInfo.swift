//
//  FilmInfo.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import Foundation

/// A structure representing film information from the iTunes API.
///
/// - Properties:
///   - trackID: The unique identifier for the film.
///   - trackName: The name of the film.
///   - previewURL: The URL for the video preview of the film.
///   - artworkUrl100: The URL for the film's artwork (image).
///   - releaseDate: The release date of the film.
///   - primaryGenreName: The primary genre of the film.
///   - longDescription: A detailed description of the film.
struct FilmInfo: Codable {
  let trackID: Int
  let trackName: String
  let previewURL: URL
  let artworkUrl100: URL
  let releaseDate: Date
  let primaryGenreName: String
  let longDescription: String

  private enum CodingKeys: String, CodingKey {
    case trackID = "trackId"
    case trackName
    case previewURL = "previewUrl"
    case artworkUrl100
    case releaseDate
    case primaryGenreName
    case longDescription
  }
}
