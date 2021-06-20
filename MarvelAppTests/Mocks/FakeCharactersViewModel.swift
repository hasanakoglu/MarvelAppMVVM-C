//
//  FakeCharactersViewModel.swift
//  Marvel AppTests
//
//  Created by Hasan Akoglu on 20/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation
import UIKit

@testable import Marvel_App

class FakeCharactersViewModel: CharactersViewModelProtocol {
    var listOfCharacters: [MarvelCharacter] = [MarvelCharacter.characterStub()]
    
    var characterImages: [String : UIImage] = [:]
    
    var fetchCharactersCalled: Bool = false
    func fetchCharacters(completion: @escaping () -> ()) {
        fetchCharactersCalled = true
        return
    }
    
    var getImageCalled = true
    var testImage = UIImage(named: "test")
    func getImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        if getImageCalled == true {
            completion(testImage)
        } else {
            completion(nil)
        }
    }
}
