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
    
    func start() {
        let viewModel = FavouritesViewModel()
        let favouritesViewController = FavouritesViewController(viewModel: viewModel)
        favouritesViewController.coordinator = self
        router.pushViewController(favouritesViewController, animated: true)
    }
    
    func didSelect(character: MarvelCharacter?) {
        guard let character = character else { return }
        let viewModel = CharacterDetailsViewModel()
        let detailsViewController = CharacterDetailsViewController(character: character, viewModel: viewModel)
        router.pushViewController(detailsViewController, animated: true)
    }
}
