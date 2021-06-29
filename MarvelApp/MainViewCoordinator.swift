//
//  MainViewCoordinator.swift
//  Marvel App
//
//  Created by Hasan Akoglu on 26/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation
import UIKit

final class MainViewCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let viewModel = CharactersViewModel(request: CharacterRequest())
        let mainViewController = MainViewController(viewModel: viewModel)
        mainViewController.coordinator = self
        router.pushViewController(mainViewController, animated: true)
    }
    
    func didSelect(character: MarvelCharacter?) {
        guard let character = character else { return }
        let viewModel = CharacterDetailsViewModel()
        let detailsViewController = CharacterDetailsViewController(character: character, viewModel: viewModel)
        router.pushViewController(detailsViewController, animated: true)
    }
}
