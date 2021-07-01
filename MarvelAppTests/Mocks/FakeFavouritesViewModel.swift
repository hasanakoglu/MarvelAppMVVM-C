//
//  FakeFavouritesViewModel.swift
//  Marvel AppTests
//
//  Created by Hasan Akoglu on 30/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation

@testable import Marvel_App

class FakeFavouritesViewModel: FavouritesViewModelProtocol {
    var favourites: [MarvelCharacter] = []
        
    func viewWillAppear() {
    }
    
    var addToFavouritesCalled = false
    func addToFavourites(character: MarvelCharacter) {
        addToFavouritesCalled = true
    }
    
    func removeFromFavourites(character: MarvelCharacter) {
    }
}
