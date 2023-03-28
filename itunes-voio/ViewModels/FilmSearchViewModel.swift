//
//  FilmSearchViewModel.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import Foundation

class FilmSearchViewModel {
    var searchResults: [FilmInfo] = []

    func searchFilms(searchTerm: String, completion: @escaping (Error?) -> Void) {
        // Fetch film info using the iTunes API
    }
}
