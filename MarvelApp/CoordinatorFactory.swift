//
//  CoordinatorFactory.swift
//  Marvel App
//
//  Created by Hasan Akoglu on 26/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func makeMainViewCoordinator(router: Router) -> Coordinator
    func makeFavouritesCoordinator(router: Router) -> Coordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeMainViewCoordinator(router: Router) -> Coordinator {
        MainViewCoordinator(router: router)
    }
    
    func makeFavouritesCoordinator(router: Router) -> Coordinator {
        FavouritesCoordinator(router: router)
    }
}
