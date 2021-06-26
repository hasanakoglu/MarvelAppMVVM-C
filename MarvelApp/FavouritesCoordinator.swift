//
//  FavouritesCoordinator.swift
//  Marvel App
//
//  Created by Hasan Akoglu on 26/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation
import UIKit

final class FavouritesCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {}
    
    func didSelect(character: MarvelCharacter?) {}
}
