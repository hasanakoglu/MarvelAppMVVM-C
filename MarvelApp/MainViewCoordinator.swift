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
        let vc = MainViewController(viewModel: viewModel)
        vc.coordinator = self
        router.pushViewController(vc, animated: true)
    }
    
    func didSelect(character: MarvelCharacter?) {
        guard let character = character else { return }
        let viewModel = CharacterDetailsViewModel()
        let detailsVC = CharacterDetailsViewController(character: character, viewModel: viewModel)
        router.pushViewController(detailsVC, animated: true)
    }
}
