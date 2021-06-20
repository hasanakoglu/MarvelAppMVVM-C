//
//  MockCharacterRequest.swift
//  Marvel AppTests
//
//  Created by Hasan Akoglu on 20/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation

@testable import Marvel_App

class MockCharacterRequest: CharacterRequestProtocol {
    var fetchCharactersCalled: Bool = false
    func fetchCharacters(completion: @escaping (Result<[MarvelCharacter], CharacterError>) -> ()) {
        if fetchCharactersCalled == true {
            completion(.success([MarvelCharacter.characterStub()]))
        } else  {
            completion(.failure(CharacterError.noData))
        }
        return
    }
}
