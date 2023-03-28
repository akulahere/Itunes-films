//
//  ItunesResponse.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import Foundation


struct ItunesResponse: Codable {
  
  let resultCount: Int
  let results: [FilmInfo]
}
