//
//  FakeCharacterDetailsViewModel.swift
//  Marvel App
//
//  Created by Hasan Akoglu on 29/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation

@testable import Marvel_App

class FakeCharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    var favourites: [MarvelCharacter] = []
        
    func viewWillAppear() {
    }
    
    func addToFavourites(character: MarvelCharacter) {
    }
    
    func removeFromFavourites(character: MarvelCharacter) {
    }
    
    func buttonSelectedState(character: MarvelCharacter) -> Bool {
        true
    }
}
