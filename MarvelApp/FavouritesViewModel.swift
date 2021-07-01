//
//  FavouritesViewModel.swift
//  Marvel App
//
//  Created by Hasan Akoglu on 29/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation

protocol FavouritesViewModelProtocol {
    var favourites: [MarvelCharacter] { get set }
    func viewWillAppear()
}

class FavouritesViewModel: FavouritesViewModelProtocol {
    var favourites = [MarvelCharacter]()
    var favouritesManager: FavouritesManagerProtocol
    
    init(favouritesManager: FavouritesManagerProtocol = FavouritesManager()) {
        self.favouritesManager = favouritesManager
    }
    
    func viewWillAppear() {
        favourites = favouritesManager.retrieveFavourites()
    }
}
