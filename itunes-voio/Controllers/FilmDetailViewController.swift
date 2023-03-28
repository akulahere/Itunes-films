//
//  FilmDetailViewController.swift
//  itunes-voio
//
//  Created by Dmytro Akulinin on 28.03.2023.
//

import UIKit

class FilmDetailViewController: UIViewController {
    private let film: FilmInfo

    init(film: FilmInfo) {
        self.film = film
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the detail view
    }
}
